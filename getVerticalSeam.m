function columns = getVerticalSeam(I,E)
M = zeros(size(I,1),size(I,2),"double");%additional memory
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
%disp(strcat('min_j ',num2str(min_j)));
columns = zeros (size(I,1),1,'uint16');
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

end