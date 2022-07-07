function J = removeVerticalSeam(I,columns,k)
J = zeros(size(I,1),size(I,2) - 1,'double');
for i=1:size(I)
    %befor remove
    J(i,1:columns(i) - 1) = I(i,1:columns(i) - 1);
    J(i,columns(i):(size(I,2) - 1)) = I(i,(columns(i) + 1): size(I,2));
    if(columns(i) > 1)
        J(i,columns(i) - 1) = k * J(i,columns(i) - 1);
    end
    if(columns(i)<size(I,2))
        J(i,columns(i)) = k * J(i,columns(i));
    end
end

end