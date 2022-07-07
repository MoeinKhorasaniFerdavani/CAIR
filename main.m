
clc;
close all;
image_name = "Diana";
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

for n=1:round(.5 * size(R,2))
    
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

pause(.01);

end

figure,imshow(I);


%functions







