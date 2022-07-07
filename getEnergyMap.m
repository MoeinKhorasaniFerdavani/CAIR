function energy_map = getEnergyMap(J,image_name)
%calcultegradient energy map and its weight
gradient_energy_map = getGradient(J);
gradient_variance= getVareOfOtsu(gradient_energy_map);

%calculte Saliecny energy map and its weight
saliency_energy_map = im2double(imread(strcat("Images\",image_name,"_SMap.png")));
saliency_variance = getVareOfOtsu(saliency_energy_map);

%%calculte Depth energy map and its weight
depth_energy_map = im2double(imread(strcat("Images\",image_name,"_DMap.png")));
depth_variance = getVareOfOtsu(depth_energy_map);

%calcute the weights of each map
sum_variance = gradient_variance + saliency_variance + depth_variance;

gradient_weight = (sum_variance - gradient_variance)^2;
saliency_weight = (sum_variance - saliency_variance)^2;
depth_weight = (sum_variance - depth_variance)^2;

energy_map = gradient_weight*gradient_energy_map + saliency_weight*saliency_energy_map + depth_weight*depth_energy_map;
max_of_energy_map = max(max(energy_map));
energy_map = energy_map/max_of_energy_map;
end