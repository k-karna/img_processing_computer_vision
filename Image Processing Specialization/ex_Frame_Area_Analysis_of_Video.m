%% Frame Area Analysis of First and Last Frame from a Video
% 

v = VideoReader("shuttle.avi");
v.FrameRate
 v =VideoReader('shuttle.avi');
 nFrames=v.numFrames;
 for i = 1:nFrames
 frames = read(v,i);
 imwrite(frames,['Image' int2str(i), '.jpg']);
 image(frames);
 end

 
%% 
% coverting to gray

 contents = dir('*.jpg')
 for k = 1:numel(contents)
  filename   = contents(k).name;
  rgbImg     = imread(filename);
  gsImg      = im2gray(rgbImg);
  [~,name,~] = fileparts(filename);
  gsFilename = sprintf('%s_gs.jpg', name);
  imwrite(gsImg,gsFilename);
 end

%% 
% Function Below implemented through Image Batch Processor App to get to know 
% required answer

 function results = whitelight(X)
%segmentImage Segment image using auto-generated code from Image Segmenter app
%  [BW,MASKEDIMAGE] = segmentImage(X) segments image X using auto-generated
%  code from the Image Segmenter app. The final segmentation is returned in
%  BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 04-Jan-2023
%----------------------------------------------------
X = im2gray(X);

% Threshold image - manual threshold
BW = X > 245;

% Create masked image.
%maskedImage = X;
%maskedImage(~BW) = 0;

% Get properties
props = regionprops("table",BW,"Area","EulerNumber");

% Uncomment the following line to return the properties in a table.
%props = struct2table(props);

results.BW = BW;
results.region = sum(props.EulerNumber);
results.Area = props.Area;

 end