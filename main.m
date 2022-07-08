
clc;
close all;
image_name = "Diana";
I = im2double(imread(strcat("Images\",image_name,".png")));

figure,imshow(I);




J = im2gray(I);

figure,imshow(J);

energy_map = getEnergyMap(J,image_name);

figure,imshow(energy_map);
figure,imshow(energy_map);
I_copy = I;
for n=1:round(.3 * size(I_copy,2))
    
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

disp(strcat(num2str(round(n/size(I_copy,2)*100)),"%    of total width is removed"));



end

figure,imshow(I);

disp('Start Auto cropping');
I = myAutoCrop(I,energy_map,6/7);
figure,imshow(I);

disp('%40    of total width is removed');

disp('Start resizing');
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
R = imresize(R,[size(I,1) int16(round(size(I,2)*5/6))]);
G = imresize(G,[size(I,1) int16(round(size(I,2)*5/6))]);
B = imresize(B,[size(I,1) int16(round(size(I,2)*5/6))]);
I = cat(3,R,G,B);
figure,imshow(I);
%imwrite(I,strcat(image_name,".png"));

disp('%50    of total width is removed');

%functions







