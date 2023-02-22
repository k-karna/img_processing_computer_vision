%% Practice Adjusting Contrast
% The original image has been read into the variable |img|.  
%% 
% * Adjust the histogram to use the full range of available pixels, and save 
% the result to the variable |imgAdj|.  
% * Next, apply histogram equalization to the original image (|img)| and save 
% the result to the variable |imgEq|. 
%% 
% Use the |montage| function to visualize your results.

% The original, underexposed image 
img = imread("foosballBW.jpg");
% Add your solution code below.
% Feel free to plot the histograms to verify the adjustments.
imgAdj = imadjust(img);
imhist(imgAdj);
montage({img, imgAdj})
imgEq = histeq(img);
imhist(imgEq);
montage({img,imgEq});