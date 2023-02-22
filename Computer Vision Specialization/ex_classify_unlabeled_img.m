%% Classify an Unlabeled Ground Cover Image
% To classify a new, unlabeled image, you must extract predictor features from 
% the image. The trained models can then asses these predictor features and make 
% a class prediction for the image. 
% 
% If your function does not pass the assessment, go back to the project introduction 
% reading and refine your approach in MATLAB.
% 
% You will be assessed on:
%% 
% # Predictor feature values for |gcTableSaturation.avgSat| and |gcTableSaturation.stdSat|
% # Predicted classification of the unlabeled image in |gcTableSaturation.prediction|
% # Predictor feature values for |gcTableBag.f1| through |gcTableBag.f500|
% # Predicted classification of the unlabeled image in |gcTableBag.prediction|
%% 
% We are providing you with the following:
%% 
% * |img| - the unlabeled image in the RGB color space.
% * |gcClassifierSaturation| - an SVM model trained to classify ground cover 
% images using hand-selected predictor features based on image saturation values.
% * |gcClassifierBag| - an SVM model trained to classify ground cover images 
% using predictor features automatically generated using the |bagOfFeatures| function.
% * |bag| - the bag of visual words object used to encode the predictor features 
% used to train |gcClassifierBag|. 

img = imread("ocean.jpg");      % Load the unlabeled image
load gcClassifierSaturation.mat % Load the model trained using hand-selected features
load gcClassifierBag.mat        % Load the model trained using automatically generated features
load bag.mat                    % Load bag of visual words object created by bagOfFeatures

% Paste your code from "predictUnlabeledGroundCoverImage.mlx" here:
imshow(img);
gcTableSaturation = extractRoadSideFeature(img);
featNames = "f" + string(1:500);
bag1 = encode(bag, img);
gcTableBag = array2table(bag1,"VariableNames",featNames);

gcTableSaturation.prediction = gcClassifierSaturation.predictFcn(gcTableSaturation)
gcTableBag.prediction = gcClassifierBag.predictFcn(gcTableBag)


%%
function gcTableSaturation = extractRoadSideFeature(img)
  
imgHSV = rgb2hsv(img); % Convert an RGB image to HSV
img1 = imgHSV(:,:,2); % Save the image saturation data
    
avgSat = mean(img1(:));
stdSat = std(img1(:));
gcTableSaturation = table(avgSat,stdSat);
end