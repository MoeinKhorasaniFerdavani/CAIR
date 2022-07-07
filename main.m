
clc;
close all;
disp(f(0));
disp(f(1/4));
disp(f(1/2));
disp(f(3/4));
disp(f(7/8));
disp(f(15/16));
disp(f(1));
I = im2double(imread("Images\Baby.png"));
figure,imshow(I);
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,2);
J = (R+G+B)/3;
figure,imshow(J);
horizental_sobel=fspecial('sobel');
h_gradian = imfilter(J,horizental_sobel);
vertical_sobel=fspecial('sobel').';
v_gradian = imfilter(J,vertical_sobel);
gradian = sqrt((h_gradian).^2+(v_gradian).^2);
%normalize gradian
max_gradian = max(max(gradian));
eg = gradian/max_gradian;
dg = getVareOfOtsu(eg);
es = im2double(imread("Images\Baby_SMap.png"));
ds = getVareOfOtsu(es);
ed = im2double(imread("Images\Baby_DMap.png"));
dd = getVareOfOtsu(ed);
d_sum = dg + ds + dd;
dg = (d_sum - dg)^2;
ds = (d_sum - ds)^2;
dd = (d_sum - dd)^2;
gradian = dg*eg + ds*es + dd*ed;
max_gradian = max(max(gradian));
gradian = gradian/max_gradian;
%disp(strcat('d:',num2str(getAvgDiffrenceOfOtsu(gradian))));
%h = hist(gradian);
plot(h);
figure,imshow(gradian);
figure,imshow(gradian);

for n=1:round(.5 * size(R,2))
    tic
seam = getVerticalSeam(J,gradian);

K = I;
for i =1:size(J,1)
    j = seam(i);
    K(i,j,1) = 1;
    K(i,j,2) = 0;
    K(i,j,3) = 0;
end
J = removeVerticalSeam(J,seam,1);
gradian = removeVerticalSeam(gradian,seam,1.2);
    
I = removeVerticalSeamTreeChannel(I,seam);
toc
imshow(K);

disp(round(n/size(R,2)*100));

pause(.01);

end

figure,imshow(I);


%functions
function columns = getVerticalSeam(I,E)
M = zeros(size(I,1),size(I,2),"double");%additional memory
%intial condition of first row
M(1,:) = E(1,:);
%recursive 
inf_value = max(max(E))*size(I,1)*size(I,2);
for i=2:size(I,1)
     for j=1:size(I,2)
         up = M(i-1,j);
         left_up = inf_value;
         right_up = inf_value;
         if j>1
             left_up = M(i-1,j-1);
         end
         if j<size(I,2)
             right_up = M(i-1,j+1);
         end
         M(i,j) = min(min(left_up,up),right_up) + E(i,j);
     end
end
%now we need backtrack to find optimal seam
%start from last line
min_value = inf_value;
min_j = 0;
for j=1:size(I,2)
if M(size(I,1),j) < min_value
    min_value = M(size(I,1),j);
    min_j = j;
end
%disp(strcat('min_j ',num2str(min_j)));
columns = zeros (size(I,1),1,'uint16');
columns(size(I,1)) = min_j;
for k=0:size(I,1)-2
    i = size(I,1) - k;
    up = M(i-1,min_j);
    left_up = inf_value;
    right_up = inf_value;
    if min_j>1
       left_up = M(i-1,min_j - 1);
    end
    if min_j<size(I,2)
       right_up = M(i-1,min_j + 1);
    end
    if  min(min(left_up,up),right_up) == left_up
        columns(i-1) = min_j - 1;
        min_j = min_j - 1;
    elseif  min(min(left_up,up),right_up) == up
        columns(i-1) = min_j;
    else
        columns(i-1) = min_j + 1;
        min_j = min_j + 1;
    end
end
end

end

function J = removeVerticalSeam(I,columns,k)
J = zeros(size(I,1),size(I,2) - 1,'double');
for i=1:size(I)
    %befor remove
    J(i,1:columns(i) - 1) = I(i,1:columns(i) - 1);
    J(i,columns(i):(size(I,2) - 1)) = I(i,(columns(i) + 1): size(I,2));
    if(columns(i) > 1)
        J(i,columns(i) - 1) = k * J(i,columns(i) - 1);
    end
    if(columns(i)<size(I,2))
        J(i,columns(i)) = k * J(i,columns(i));
    end
end

end

function J = removeVerticalSeamTreeChannel(I,columns)
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
R = removeVerticalSeam(R,columns,1);
G = removeVerticalSeam(G,columns,1);
B = removeVerticalSeam(B,columns,1);
J = cat(3,R,G,B);
end
function J = f(I)
J = I.*(((1/2)^(2/3))*((abs(I - 1/2))^(1/3))*(I>1/2) + 1/2);
end
function E = getSaliencyMap(I)
end
function d = getVareOfOtsu(I)
level = multithresh(I);
bw = im2bw(I,level);
%figure,imshow(bw);
%imshow(bw);
K1 = [];
K2 = [];
for i=1:size(I,1)
    for j=1:size(I,2)
        if bw(i,j) == 1
            K1(size(K1,2)+1) = I(i,j);
        else
            K2(size(K2,2)+1) = I(i,j);
        end
    end
end
v1 = var(K1(:));
v2 = var(K2(:));
d = v1*numel(K1) + v2*numel(K2);
end