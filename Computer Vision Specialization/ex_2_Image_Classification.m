%% 
% In this assessment, you will prepare your images for classification and extract 
% saturation-based features. 
% 
% These features will be used to train a classification model in the next section, 
% so it is important that you take this quiz as many times as necessary to ensure 
% that your data set is correctly prepared and ready for classification.

fileLocation = uigetdir();
dsroadSide = imageDatastore(fileLocation,"IncludeSubFolders",true,"LabelSource","foldernames");
categories(dsroadSide.Labels)
%% 
% Organize the Roadside Ground Cover images (which can be found in the "MathWorks 
% Images" subfolder of the "Data" folder in the course files download) into an 
% image datastore. Use the subfolder names "Snow" and "No Snow" as the image labels.
% 
% Then split the datastore into training and testing subsets while keeping *85%* 
% of the images in the training datastore.
% 
% How many images are labeled as "Snow" in the *training* datastore?

[dsTrain,dsTest] = splitEachLabel(dsroadSide,0.85,"randomize");
countEachLabel(dsTrain)
%% 
% 

%img = imread("Data/MathWorks Images/Roadside Ground Cover/No Snow/RoadsideA_1.jpg");
%result = imgSat(img)
%% 
% Question 2: What is the *mean saturation* for the "No Snow" labeled image 
% "RoadsideA_1.jpg"?
% 
% Question 3: What is the *standard deviation of the saturation* for the "No 
% Snow" labeled image "RoadsideA_1.jpg"?
% 
% 
% 
% Question 4
% 
% Create a table for the training dataset that contains a row for each image 
% and a column for its:
%% 
% * Filename
% * Label (either "Snow" or "No Snow")
% * Mean saturation
% * Standard deviation of the saturation

roadSide = extractRoadSideFeature(dsTrain);
%% Save the Information Needed to Train a Model
% *Make a note of your current folder; this is where this line of code will 
% save your .mat file;* you will need it later.

save RoadSideFature.mat roadSide dsTrain dsTest
%% 
% Once completed, make a grouped scatter plot of each image's mean saturation 
% on the x-axis and the standard deviation of the saturation on the y-axis. What 
% is the result?

gscatter(roadSide.intensityAvg,roadSide.intensitySTD,roadSide.label)
xlabel("Mean Saturation")
ylabel("STD of Saturation")
%%
function roadSide = extractRoadSideFeature(ds)

intensityAvg = [];
intensitySTD = [];
imgName = [];

while hasdata(ds)

    [img,info] = read(ds);
    
    imgHSV = rgb2hsv(img); % Convert an RGB image to HSV
    img = imgHSV(:,:,2); % Save the image saturation data
    
    intensityAvg = [intensityAvg; mean(img(:))];
    intensitySTD = [intensitySTD; std(img(:))];
    
    [~,name,ext] = fileparts(info.Filename);
    imgName = [imgName; string(name) + string(ext)];

end

label = categorical(ds.Labels);
roadSide = table(label,imgName,intensityAvg,intensitySTD);
end



%function stdSat = imgSat(img)
%imgHSV = rgb2hsv(img); % Convert an RGB image to HSV
%imgSaturation = imgHSV(:,:,2); % Save the image saturation data
%meanSat = mean(imgSaturation(:));
%stdSat = std(imgSaturation(:));
%end