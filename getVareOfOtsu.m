function d = getVareOfOtsu(I)
level = multithresh(I);
bw = im2bw(I,level);
%figure,imshow(bw);
%imshow(bw);
K1 = [];
K2 = [];
for i=1:size(I,1)
    for j=1:size(I,2)
        if bw(i,j) == 1
            K1(size(K1,2)+1) = I(i,j);
        else
            K2(size(K2,2)+1) = I(i,j);
        end
    end
end
v1 = var(K1(:));
v2 = var(K2(:));
d = v1*numel(K1) + v2*numel(K2);
end