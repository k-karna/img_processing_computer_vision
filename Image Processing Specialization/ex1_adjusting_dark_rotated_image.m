%% *Adjusting a Dark and Rotated Image*
% Gamma Correction is a common image adjustment technique. Each pixel in an 
% image is raised to a power, gamma, such that
% 
% 
% 
% In this problem you will adjust the brightness using gamma correction and 
% correct the rotation of the Boston Night image.
% 
% Write a script that converts the "boston night.JPG" image to grayscale and 
% performs the following two adjustments:
%% 
% * adjust the intensity using  in the above equation
% * rotate the image 1 degree clockwise while maintaining the same image dimensions
%% 
% Store your final image as |uint8| in a variable named |*imgAdjusted*|
% 
% You're encouraged to work in MATLAB to develop your solution before testing 
% it here. 

img = imread("boston night.JPG");
% Enter your code below
gs_img = rgb2gray(img);
gs_gamma_img = imadjust(gs_img,[],[],0.5);
gs_gamma_rotate_img = imrotate(gs_gamma_img,-1,"crop");
imgAdjusted = im2uint8(gs_gamma_rotate_img);
imshow(imgAdjusted);