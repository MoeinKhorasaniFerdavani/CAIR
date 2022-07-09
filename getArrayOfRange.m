function K = getArrayOfRange(I,a,b)
K = [];
for i=1:size(I,1)
    for j=1:size(I,2)
        if I(i,j)>a && I(i,j) < b
            K(end + 1) = I(i,j);
        end
    end
end
end