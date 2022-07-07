
clc;
close all;

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
gradian = removeVerticalSeam(gradian,seam,1.15);
    
I = removeVerticalSeamTreeChannel(I,seam);
toc
imshow(K);

disp(round(n/size(R,2)*100));

pause(.01);

end

figure,imshow(I);


%functions







