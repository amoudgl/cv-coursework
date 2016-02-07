clear;
close all;
clc; 

% location = '/Users/abhinavmoudgil95/Documents/MATLAB/CV/assignment1/images/zhang-images/';
location = '/Users/abhinavmoudgil95/Documents/MATLAB/cv-coursework/assignment1/images/my-checkerboard-images/';
images = imageSet(location);
imageFileNames = images.ImageLocation;
[imagePoints, boardSize] = detectCheckerboardPoints(imageFileNames);
squareSizeInMM = 29;
worldPoints = generateCheckerboardPoints(boardSize,squareSizeInMM);
params = estimateCameraParameters(imagePoints,worldPoints);
showReprojectionErrors(params);

figure;
imshow(imageFileNames{1});
hold on;
plot(imagePoints(:,1,1), imagePoints(:,2,1),'go');
plot(params.ReprojectedPoints(:,1,1), params.ReprojectedPoints(:,2,1),'r+');
legend('Detected Points','ReprojectedPoints');
hold off;
