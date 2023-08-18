% Paste your solution code from "Project: Applying Optical Flow to Detect Moving Objects" here:
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


% Write new code to count the number of cars moving in each direction and their x-direction velocities
% Calculate x-direction velocities
velocities = flow.Vx;

% Calculate average Vx for each object in the mask
regions = regionprops(mask, 'PixelIdxList');
avgVxPerObject = zeros(1, numel(regions));

for i = 1:numel(regions)
    pixelIdxList = regions(i).PixelIdxList;
    avgVx = mean(velocities(pixelIdxList));
    avgVxPerObject(i) = avgVx;
end

% Initialize variables
leftVx = [];
rightVx = [];
numCarsLeft = 0;
numCarsRight = 0;

% Identify cars moving left or right based on average Vx
for i = 1:numel(regions)
    avgVx = avgVxPerObject(i);
    
    if avgVx < 0 && abs(avgVx) > 3
        leftVx(end + 1) = avgVx;
        numCarsLeft = numCarsLeft + 1;
    elseif avgVx > 0 && avgVx > 3
        rightVx(end + 1) = avgVx;
        numCarsRight = numCarsRight + 1;
    end
end

%added by pythoner-code(Himanshu).
