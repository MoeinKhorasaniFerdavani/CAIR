clc;
clc;
close all;
I = im2double(imread("Images\dr_hosein_falsafein.jpg"));
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
gradian = abs(h_gradian)+abs(v_gradian);
%normalize gradian
max_gradian = max(max(gradian));
gradian = gradian/max_gradian;
figure,imshow(gradian);
seam = getVerticalSeam(J,gradian);
K = I;
for i =1:size(J,1)
    j = seam(i);
    K(i,j,1) = 1;
    K(i,j,2) = 0;
    K(i,j,3) = 0;
end
figure,imshow(K);
%functions
function columns = getVerticalSeam(I,E)
M = zeros(size(I,1),size(I,2),"int32");%additional memory
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
columns = zeros (size(I,1),1,'int8');
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
b =2;
end