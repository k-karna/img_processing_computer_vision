%% Analyzing concrete crack image data
% The goal of this assessment is to analyze the concrete crack image data from 
% the previous video. You will use the |crackData| table, which is provided in 
% your course files in the file |CrackData.mat|.
% 
% In each concrete crack image, a single pixel has the dimensions of *0.5 mm* 
% by *0.5 mm*.
%% Use the MATLAB script below to perform the following tasks:
%% 
% # Convert the |MaxWidth| variable in the |cackData| table from number-of-pixels 
% to millimeters.
% # Convert the |Area| variable in the |cackData| table from number-of-pixels 
% to squared millimeters.
% # Calculate the mean |MaxWidth| in millimeters for all images with a |Risk| 
% of |Mild|. Save this value in the variable |mildMeanWidth|.
% # Calculate the mean |MaxWidth| in millimeters for all images with a |Risk| 
% of |Severe|. Save this value in the variable |severeMeanWidth|.

load CrackData.mat
crackData
%%
cutoffArea = 4000;
crackData.Risk = discretize(crackData.Area,[0,cutoffArea,inf], ...
    "categorical",["Mild","Severe"]);
%%
%As a single pixel has height of 0.5 mm and width of 0.5 mm
crackData.MaxWidth = crackData.MaxWidth * 0.5;
%Area of pixel is 0.5*0.5
crackData.Area = crackData.Area * 0.25;
%%
mean = groupsummary(crackData,"Risk","median","MaxWidth")
mildMeanWidth = mean(1,"median_MaxWidth");
severeMeanWidth = mean(2,"median_MaxWidth");
%%


% Remove outliers
[newTable3,outlierIndices2,~,thresholdLow,thresholdHigh] = rmoutliers(crackData,...
    "DataVariables","MaxWidth");

% Display results
figure
plot(crackData.MaxWidth,"Color",[77 190 238]/255,"DisplayName","Input data")
hold on
plot(find(~outlierIndices2),newTable3.MaxWidth,"Color",[0 114 189]/255,...
    "LineWidth",1.5,"DisplayName","Cleaned data")

% Plot outliers
plot(find(outlierIndices2),crackData.MaxWidth(outlierIndices2),"x",...
    "Color",[217 83 25]/255,"DisplayName","Outliers")

% Plot outlier thresholds
plot([xlim missing xlim],...
    [thresholdLow.MaxWidth*[1 1] NaN thresholdHigh.MaxWidth*[1 1]],...
    "Color",[145 145 145]/255,"DisplayName","Outlier thresholds")

hold off
title("Number of outliers cleaned: " + nnz(outlierIndices2))
legend
ylabel("MaxWidth")
clear thresholdLow thresholdHigh
%%
outlierImages = crackData.fileName(outlierIndices);
montage(outlierImages,"BorderSize",1);