%% Use a Median Filter to Reduce Noise
% "Salt and Pepper" noise has discrete pixels with extremely high- and low-intensity 
% values, making averaging filters a nonideal choice for noise removal:
% 
% Create code that filters the image using a 3x3 median filter, saves the result 
% as "imgMed", and displays the result.

% Load in the noisy image
img = imread("coinsNoisy.jpg");


% Insert code here to filter and display the image
imgMed = medfilt2(img, [3,3]);
% Uncomment the line below to display the results
montage({img,imgMed})