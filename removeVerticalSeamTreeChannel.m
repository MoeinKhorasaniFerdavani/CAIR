function J = removeVerticalSeamTreeChannel(I,columns)
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
R = removeVerticalSeam(R,columns,1);
G = removeVerticalSeam(G,columns,1);
B = removeVerticalSeam(B,columns,1);
J = cat(3,R,G,B);
end