function m = getDiffOfOtsu(I)
%I = imadjust(I,[.01,.99]);
I = getArrayOfRange(I,0.01,0.99);
level = multithresh(I);
bw = im2bw(I,level);
%figure,imshow(bw);
%imshow(bw);
K1 = [];
K2 = [];
for i=1:size(I,2)
    %for j=1:size(I,2)
        if bw(i) == 1
            K1(end+1) = I(i);
        else
            K2(end+1) = I(i);
        end
    %end
end
v1 = var(K1(:));
v2 = var(K2(:));
t = sort(K1);
m1 = t(uint16(round(numel(t)/20)));
t = sort(K2);
m2 = t(uint32(round(numel(t)/20*19)));
disp(strcat('m: ',num2str(m1 - m2)));
d = v1*numel(K1) + v2*numel(K2);
m = m1 - m2;
end