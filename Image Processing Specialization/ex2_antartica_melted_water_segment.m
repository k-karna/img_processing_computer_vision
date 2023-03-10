function [BW,maskedRGBImage] = segmentMeltwater(RGB)
%% SEGMENTMELTWATER Test Your Antartica Water Segmentation Function
% Create a function to segment the Antarctica ice shelf images using the Color 
% Thresholder app as described in the previous reading. You can use this function 
% to calculate the increase in visible water between the two images.
% 
% Copy the code from your generated function into the first code box below.
% 
% We've provided a function name for you below, |segmentMeltwater|. Copy the 
% code from inside your function (do not copy the first line or the last |*end*|, 
% just the code inside) and paste into the first code box below. Use the Run Function 
% button to make sure you've copied the code over correctly and it works before 
% submitting. Use the feedback to help you determine how to adjust your thresholds.
%createMask  Threshold RGB image using auto-generated code from colorThresholder app.
%  [BW,MASKEDRGBIMAGE] = createMask(RGB) thresholds image RGB using
%  auto-generated code from the colorThresholder app. The colorspace and
%  range for each channel of the colorspace were set within the app. The
%  segmentation mask is returned in BW, and a composite of the mask and
%  original RGB images is returned in maskedRGBImage.
% Auto-generated by colorThresholder app on 29-Dec-2022
%------------------------------------------------------
% Convert RGB image to chosen color space
I = rgb2ycbcr(RGB);
% Define thresholds for channel 1 based on histogram settings
channel1Min = 12.000;
channel1Max = 162.000;
% Define thresholds for channel 2 based on histogram settings
channel2Min = 132.000;
channel2Max = 205.000;
% Define thresholds for channel 3 based on histogram settings
channel3Min = 47.000;
channel3Max = 123.000;
% Create mask based on chosen histogram thresholds
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW;
% Initialize output masked image based on input image.
maskedRGBImage = RGB;
% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
end
%% 
% 
% Run this to make sure your function works properly before pressing Submit
img1 = imread("1_SnowPoolsBefore_20180113_md-2048px.jpg");
img2 = imread("2_SnowPoolsAfter_20200119_md-2048px.jpg");
[BW1, maskedImg1] = segmentMeltwater(img1);
[BW2, maskedImg2] = segmentMeltwater(img2);
figure
montage({img1, maskedImg1})
figure
montage({img2, maskedImg2})