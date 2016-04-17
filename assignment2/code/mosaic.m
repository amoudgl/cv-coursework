im1_color = imread('../images/planer_im1.jpg');
im2_color = imread('../images/planer_im2.jpg');
im1_color = imresize(im1_color, 0.25);
im2_color = imresize(im2_color, 0.25);
im1 = rgb2gray(im1_color);
im2 = rgb2gray(im2_color);

H = findHomographyDLT(im1, im2);

% Transform the image according to the obtained H matrix
T = maketform('projective', H);

% Add RGB channels to the gray image
im2(:,:,1) = im2_color(:,:,1);
im2(:,:,2) = im2_color(:,:,2);
im2(:,:,3) = im2_color(:,:,3);

im1(:,:,1) = im1_color(:,:,1);
im1(:,:,2) = im1_color(:,:,2);
im1(:,:,3) = im1_color(:,:,3);

[im2t,xdataim2t,ydataim2t]=imtransform(im2,T);

% xdataim2t and ydataim2t store the bounds of the transformed im2
xdataout=[min(1,xdataim2t(1)) max(size(im1,2),xdataim2t(2))];
ydataout=[min(1,ydataim2t(1)) max(size(im1,1),ydataim2t(2))];
im2t=imtransform(im2,T,'XData',xdataout,'YData',ydataout);
im1t=imtransform(im1,maketform('affine',eye(3)),'XData',xdataout,'YData',ydataout);

% Averaging the pixel values at the common points
ims=im1t/2+im2t/2;
figure, imshow(ims);