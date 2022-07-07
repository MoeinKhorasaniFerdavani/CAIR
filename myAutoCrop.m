function J = myAutoCrop(I,E,remain_percent)
J_width = int16(round(size(I,2)*remain_percent));
J = zeros(size(I,1),J_width,'double');
max_energy = 0;
max_index = 0;
for i=1:size(I,2)-size(J,2)+1
    energy_frame = E(:,i:size(J,2)+i-1);
    value = sum(sum(energy_frame));
    if value > max_energy
        max_index = i;
        max_energy = value;
    end
end
J = I(:,max_index:size(J,2)+i-1,:);
end