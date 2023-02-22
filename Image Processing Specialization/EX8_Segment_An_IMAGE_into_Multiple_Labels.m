%% Segment an Image into Multiple Labels
% In this problem, you will perform segmentation with code on the "Puzzle_06.jpg" 
% image included in the course files. Your goal is to segment the image into a 
% matrix of labels that differentiates the background, the red/orange puzzle pieces, 
% and the blue puzzle pieces.
% 
% Your code should do the following:
%% 
% # Create a binary mask where the puzzle pieces are foreground and the rest 
% of the image is background. Store this mask in the variable |*BW*|.
% # Segment the image by creating a labeled matrix with three groups, one for 
% the background and one for each color. Store the result in the variable |*labels*|. 
% |*labels*| should only contain the values 1, 2, and 3.
%% 
% We recommend you work out a solution in MATLAB. If you get stuck, refer back 
% to the "Segment Images with Code" reading or look at the code generated from 
% the Apps for ideas.

img=imread('Puzzle_06.jpg');
imshow(img);
title("original Image");
img2 = im2gray(img);
[BW, maskedImage] = segmentImageEx(img2);
imshow(BW);
title("Binary Masked Image");
img(repmat(~BW,1,1,3))=0;
imshow(img);
title("Original Image Background Merged with BW Image")
k = 3;
labels = imsegkmeans(img,k);
montage({img,label2rgb(labels)});
%%
function [BW,maskedImage] = segmentImageEx(X)

%segmentImage Segment image using auto-generated code from Image Segmenter app
%  [BW,MASKEDIMAGE] = segmentImage(X) segments image X using auto-generated
%  code from the Image Segmenter app. The final segmentation is returned in
%  BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 31-Dec-2022
%----------------------------------------------------


% Threshold image - adaptive threshold
BW = imbinarize(im2gray(X), 'adaptive', 'Sensitivity', 0.500000, 'ForegroundPolarity', 'bright');

% Open mask with disk
radius = 3;
decomposition = 8;
se = strel('disk', radius, decomposition);
BW = imopen(BW, se);

% Dilate mask with disk
radius = 2;
decomposition = 0;
se = strel('disk', radius, decomposition);
BW = imdilate(BW, se);

% Create masked image.
maskedImage = X;
maskedImage(~BW) = 0;
end
%% 
%