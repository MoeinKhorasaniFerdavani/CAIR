function energy_map = getEnergyMap(J,image_name)
%calcultegradient energy map and its weight
gradient_energy_map = getGradient(J);
figure,imhist(gradient_energy_map);
gradient_diff= getDiffOfOtsu(gradient_energy_map);
gradient_diff = gradient_diff / 2;
%calculte Saliecny energy map and its weight
saliency_energy_map = im2double(imread(strcat("Images\",image_name,"_SMap.png")));
figure,imhist(saliency_energy_map);
saliency_diff = getDiffOfOtsu(saliency_energy_map);

%%calculte Depth energy map and its weight
depth_energy_map = im2double(imread(strcat("Images\",image_name,"_DMap.png")));
figure,imhist(depth_energy_map);
depth_diff = getDiffOfOtsu(depth_energy_map);
depth_diff = depth_diff * 2;
%depth_variance = depth_variance / 2;

%calcute the weights of each map
gradient_weight = sqrt(gradient_diff);
saliency_weight = sqrt(saliency_diff);
depth_weight = sqrt(depth_diff);
%sum_variance = gradient_variance + saliency_variance + depth_variance;



% gradient_weight = (sum_variance - gradient_variance)^2;
% saliency_weight = (sum_variance - saliency_variance)^2;
% depth_weight = (sum_variance - depth_variance)^2;
energy_map = gradient_weight*gradient_energy_map + saliency_weight*saliency_energy_map + depth_weight*depth_energy_map;
%energy_map= depth_energy_map;
max_of_energy_map = max(max(energy_map));
energy_map = energy_map/max_of_energy_map;
end