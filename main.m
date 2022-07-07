
clc;
close all;
image_name = "Baby";
I = im2double(imread(strcat("Images\",image_name,".png")));

figure,imshow(I);

%create Gray image using this function instead of im2gray to have the same
%weight for each chanel

R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,2);
J = (R+G+B)/3;
figure,imshow(J);

energy_map = getEnergyMap(J,image_name);

figure,imshow(energy_map);
figure,imshow(energy_map);

for n=1:round(.3 * size(R,2))
    
seam = getVerticalSeam(J,energy_map);

K = I;
for i =1:size(J,1)
    j = seam(i);
    K(i,j,1) = 1;
    K(i,j,2) = 0;
    K(i,j,3) = 0;
end
J = removeVerticalSeam(J,seam,1);
energy_map = removeVerticalSeam(energy_map,seam,1.15);
    
I = removeVerticalSeamTreeChannel(I,seam);

imshow(K);

disp(strcat(num2str(round(n/size(R,2)*100)),"%    of total width is removed"));



end

figure,imshow(I);


I = myAutoCrop(I,energy_map,6/7);
figure,imshow(I);
disp('Start Auto cropping');
disp('%40    of total width is removed');


R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
R = imresize(R,[size(I,1) int16(round(size(I,2)*5/6))]);
G = imresize(G,[size(I,1) int16(round(size(I,2)*5/6))]);
B = imresize(B,[size(I,1) int16(round(size(I,2)*5/6))]);
I = cat(3,R,G,B);
figure,imshow(I);
imwrite(I,strcat(image_name,".png"));
disp('Start resizing');
disp('%50    of total width is removed');

%functions







