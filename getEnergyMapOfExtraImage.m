function energy_map = getEnergyMapOfExtraImage(J,image_name)
%calcultegradient energy map and its weight
gradient_energy_map = getGradient(J);
gradient_variance= getVareOfOtsu(gradient_energy_map);
figure,imhist(gradient_energy_map);


depth_energy_map = IR2Gray(im2double(imread(strcat("Images\",image_name,"_DMap.jpg"))));
depth_variance = getVareOfOtsu(depth_energy_map);
depth_variance = depth_variance / 2;
figure,imhist(depth_energy_map);
%calcute the weights of each map
sum_variance = gradient_variance + depth_variance;

gradient_weight = (sum_variance - gradient_variance)^2;

depth_weight = (sum_variance - depth_variance)^2;
energy_map = gradient_weight*gradient_energy_map + depth_weight*depth_energy_map;
%energy_map= depth_energy_map;
max_of_energy_map = max(max(energy_map));
energy_map = energy_map/max_of_energy_map;
end