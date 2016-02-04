close all;
clear;
clc;
im = imread('IMG_5455.JPG');
% [x, y] = ginput();

x = [4.916500e+03 4.068500e+03 3.244500e+03 2.428500e+03 1.652500e+03 8.925000e+02 1.405000e+02 4.876500e+03 4.036500e+03 3.220500e+03 2.436500e+03 1.676500e+03 9.245000e+02 1.965000e+02 4.724500e+03 3.868500e+03 3.036500e+03 2.228500e+03 1.436500e+03 6.605000e+02 4.636500e+03 3.724500e+03 2.836500e+03 1.988500e+03 1.156500e+03 3.405000e+02 4.548500e+03 3.572500e+03 2.628500e+03 1.716500e+03 8.365000e+02 4.420500e+03 3.380500e+03 2.380500e+03 1.404500e+03 4.685000e+02];
y = [5.645000e+02 5.165000e+02 4.605000e+02 4.205000e+02 3.725000e+02 3.325000e+02 2.765000e+02 1.396500e+03 1.332500e+03 1.276500e+03 1.212500e+03 1.164500e+03 1.100500e+03 1.044500e+03 2.452500e+03 2.372500e+03 2.300500e+03 2.228500e+03 2.156500e+03 2.100500e+03 2.788500e+03 2.708500e+03 2.628500e+03 2.540500e+03 2.460500e+03 2.388500e+03 3.164500e+03 3.076500e+03 2.988500e+03 2.908500e+03 2.804500e+03 3.596500e+03 3.492500e+03 3.404500e+03 3.308500e+03 3.212500e+03];

X = [0:36:216 0:36:216 0:36:180 0:36:180 0:36:144 0:36:144];
Y = [72*ones(7,1)' 36*ones(7,1)' zeros(22,1)'];
Z = [zeros(14, 1)' 36*ones(6,1)' 72*ones(6,1)' 108*ones(5,1)' 144*ones(5,1)'];

N = 250;

theta = 1;

max = 0;
XI = [x;y;ones(36,1)'];
XW = [X;Y;Z;ones(36,1)'];

for i = 1 : N
     r = [randi([1 14], 1, 3) randi([15 36], 1, 3)];
     P = fdlt(XW(:, r),XI(:, r));
     projected = P * XW;
     projected_x = projected(1, :)./projected(3, :);
     projected_y = projected(2, :)./projected(3, :);
     error_x = (abs(projected_x - x));
     error_y = (abs(projected_y - y));
     error = error_x + error_y;
      t = error < theta;
      number_of_inliers = sum(t);
     if (number_of_inliers > max)
         max = number_of_inliers;
         solution = P;
      end 
end

projected = solution * XW;
projected(1, :) = projected(1, :)./projected(3, :);
projected(2, :) = projected(2, :)./projected(3, :);

figure, imshow(im);
hold on;
plot(projected(1,:), projected(2,:), 'y*');
plot(x, y, 'r*');
hold on;

for i = 2:36
    if (i ~= 8 && i ~= 15 && i ~= 21 && i ~= 27 && i ~= 32)
    plot([projected(1, i), projected(1, i-1)], [projected(2, i), projected(2, i-1)], 'g');
    end
end

for i = 1:7
        plot([projected(1, i), projected(1, 7+i)], [projected(2, i), projected(2, 7+i)], 'g');
        if (i <= 6)
        plot([projected(1, 7+i), projected(1, 14+i)], [projected(2, 7+i), projected(2, 14+i)], 'g');
        plot([projected(1, 14+i), projected(1, 20+i)], [projected(2, 14+i), projected(2, 20+i)], 'g');  
        end
        if (i <= 5)
        plot([projected(1, 20+i), projected(1, 26+i)], [projected(2, 20+i), projected(2, 26+i)], 'g');
        plot([projected(1, 26+i), projected(1, 31+i)], [projected(2, 26+i), projected(2, 31+i)], 'g');
        end     
end
        
