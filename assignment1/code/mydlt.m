clear all;
im = imread('/Users/abhinavmoudgil95/Documents/MATLAB/cv-coursework/assignment1/images/dlt-ransac/IMG_5455.JPG');
szx = size(im, 1);
szy = size(im, 2);

x = [4.917905405405405e+03;4.868608108108108e+03;4.726878378378378e+03;4.061364864864866e+03;4.030554054054055e+03;3.864175675675676e+03];
y = [5.581756756756758e+02;1.396229729729730e+03;2.456121621621622e+03;5.150405405405404e+02;1.334608108108108e+03;2.382175675675676e+03];

X = [0,0,0,36,36,36];
Y = [72, 36, 0, 72, 36, 0];
Z = [0,0,36,0,0,36];

XI = [x';y';ones(6,1)'];
XW = [X;Y;Z;ones(6,1)'];

P = fdlt(XW,XI)
projected = P*XW;

projected(1, :) = projected(1, :)./projected(3, :);
projected(2, :) = projected(2, :)./projected(3, :);
imshow(im);
hold on;
plot(projected(1,:), projected(2,:), 'y*');
plot(x,y,'bo');
legend({'Projected Points','Original Points'}, 'FontSize',15,'FontWeight','bold');
% figure, imshow(im);
% hold on;
% plot(projected(1,:), projected(2,:), 'r*');
% 
% figure, imshow(im);
% hold on;
% plot(x, y, 'y*');
