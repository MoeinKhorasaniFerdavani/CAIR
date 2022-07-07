function gradient = getGradient(J)

%calculate gradiant of image vertical and horizental
horizental_sobel=fspecial('sobel');
h_gradient = imfilter(J,horizental_sobel);
vertical_sobel=fspecial('sobel').';
v_gradient = imfilter(J,vertical_sobel);
gradient = sqrt((h_gradient).^2+(v_gradient).^2);
%normalize gradian
max_of_gradient = max(max(gradient));
gradient = gradient/max_of_gradient;
end