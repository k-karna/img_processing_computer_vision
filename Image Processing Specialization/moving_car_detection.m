%% Moving Car Detection Project
% Task is to finding moving cars, and insert a bounding box around it

v = VideoReader("RoadTraffic.mp4");
v.FrameRate;
firstFrame = read(v,1);
firstFrame = im2double(firstFrame);

v2 = VideoWriter("car_bound1.mp4", "MPEG-4");
v2.FrameRate = v.FrameRate;
open(v2)

for idx = 1:v.NumFrames
    frame = read(v,idx);
    frame = im2double(frame);

    frameDiffer = abs (firstFrame - frame);

    bw = carjoin1(frameDiffer);

    props = regionprops("table",bw,"BoundingBox");

    carboxed = insertShape(frame,"rectangle",props.BoundingBox,...
        "LineWidth",3,"Color","red");
    writeVideo(v2,carboxed)
end
close(v2);