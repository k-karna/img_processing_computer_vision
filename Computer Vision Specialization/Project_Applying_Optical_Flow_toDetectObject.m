%% Project: Applying Optical Flow to Detect Moving Objects
% In this problem, you will:
%% 
% * Use the Farneback method to calculate the optical flow vectors between the 
% frames and save them as a variable named |flow|.
% * Create a mask including only pixels with an optical flow vector magnitude 
% above 1. Save the result as a variable named |mask|.
% * Use image processing to update |mask| to remove regions with an area below 
% 500 pixels. 
% * Use image processing to morphologically close |mask| with a structuring 
% element of type "disk" and size 20.

frame1 = imread("Rt9Frame1.png");
frame2 = imread("Rt9Frame2.png");
montage({frame2,frame1})
%%
%Calculating the optical flow vector between frame1 & frame2

myOpticalFlow = opticalFlowFarneback;
estimateFlow(myOpticalFlow,im2gray(frame1));
flow = estimateFlow(myOpticalFlow,im2gray(frame2)); 
% myOpticalFlow stores the previous frame
%%
%Just to see

imshow(frame2)
hold on
plot(flow,"DecimationFactor",[15 15],"ScaleFactor",7)
hold off
%%
%Creating Mask with optical flow magnitude 1+

vm = flow.Magnitude;
maskThreshold = 1.0;
mask = (vm(:,:)>maskThreshold);
%image processing 

se = strel("disk",20,0);
mask = bwareafilt(mask, [500, inf]);
mask = imclose(mask, se);


% Uncomment below to view your optical flow vectors on your masked image
maskedFrame = frame2; maskedFrame(repmat(~mask, [1 1 3])) = 0;
imshow(frame2)
hold on
plot(flow,"DecimationFactor",[15 15],"ScaleFactor",7)
hold off
figure
imshow(maskedFrame)