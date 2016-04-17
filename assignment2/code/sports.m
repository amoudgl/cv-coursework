im1_color = imread('../images/sports1.jpg');
im2_color = imread('../images/banner.jpg');
im1 = rgb2gray(im1_color); 
im2 = rgb2gray(im2_color);
imshow(im1_color);
x = ginput(4);
x = [x ones(4, 1)];  
x_i = dlmread('banner.txt');
n = 4;
A = zeros(2 * n, 9);
for i = 1:n
    A(2 * i - 1, :) = [zeros(1,3) -x_i(i, :) x(i,2) * x_i(i, :)];
    A(2 * i, :) = [x_i(i, :) zeros(1, 3) -x(i,1) * x_i(i, :)];
end
[U, D, V] = svd(A);
H = V(:, 9);
H = reshape(H, [3, 3]);
T = maketform('projective', H);

im2(:,:,1) = im2_color(:,:,1); 
im2(:,:,2) = im2_color(:,:,2); 
im2(:,:,3) = im2_color(:,:,3);
  
im1(:,:,1) = im1_color(:,:,1); 
im1(:,:,2) = im1_color(:,:,2); 
im1(:,:,3) = im1_color(:,:,3);
[im2t , xdataim2t , ydataim2t] = imtransform(im2 ,T);

% xdataim2t and ydataim2t store the bounds of the transformed im2
xdataout=[min(1,xdataim2t(1)) max(size(im1,2),xdataim2t(2))]; 
ydataout=[min(1,ydataim2t(1)) max(size(im1,1),ydataim2t(2))]; 
im2t=imtransform(im2,T,'XData',xdataout,'YData',ydataout); 
im1t=imtransform(im1,maketform('affine',eye(3)),'XData',xdataout,'YData', ydataout);

% Create a mask of the polygon selected to be replaced
BW = imcomplement(poly2mask(x(:, 1)', x(:, 2)', size(im2t, 1), size(im2t, 2)));
mask = cat(3, BW, BW, BW);
ims = uint8(double(im1t) .* mask + double(im2t)); 
imshow(ims) ;


