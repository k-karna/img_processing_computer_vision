%% YOLO / TinyYOLO Detection on Frame
% You'll investigate the accuracy of the YOLOv4 pre-trained network in this 
% quiz. You'll use a single frame from the MathWorksRt9 video included in with 
% the course files. Open MATLAB and start a new script with the following code:

yolo = yolov4ObjectDetector("csp-darknet53-coco");

yoloTiny = yolov4ObjectDetector("tiny-yolov4-coco");

img = imread("Rt9Frame1.png");
%% 
% *1.*Question 1
% 
% Apply the _yoloTiny_ detector to the Rt9Frame1.png image with the default 
% settings. How many objects are detected?

[bboxes,scores,labels] = detect(yoloTiny,img);
imgYoloTiny = insertObjectAnnotation(img,"rectangle",bboxes,labels);
imshow(imgYoloTiny)
%% 
% *2.*Question 2
% 
% Look at the labels for the detections from question one. What objects are 
% detected? *Select all that apply*.
%% 
% *3.*Question 3
% 
% Apply the full YOLO detector (using csp-darknet53-coco)  to the image using 
% the default "Threshold" of 0.5. How many "Car" detections are there?

[bboxes,scores,labels] = detect(yolo,img);
imgYolo = insertObjectAnnotation(img,"rectangle",bboxes,labels);
imshow(imgYolo)
%% 
% *4.*Question 4
% 
% Use the tiny YOLO detector, but decrease the detection threshold to 0.25. 
% How many objects are detected?

[bboxes,scores,labels] = detect(yoloTiny,img,Threshold=0.25);
imgYoloTiny = insertObjectAnnotation(img,"rectangle",bboxes,labels);
imshow(imgYoloTiny)