function gray_image = IR2Gray(IR)
gray_image= IR(:,:,1);
gray_image(:,:) = 3/4*IR(:,:,1)+ 1/4*IR(:,:,2);
end