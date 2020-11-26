%% Case Study Text Detection and Recognition
clc;
clear;
close all;

filename ='F:\AJ Data\img\videos\trt news headline.mp4';

vidReader = VideoReader(filename);
vidPlayer = vision.DeployableVideoPlayer;
TotalFrame = vidReader.NumFrames;

frameNo=1;
while(frameNo<TotalFrame)
    img = read(vidReader,frameNo);
    frameNo=frameNo+1;
    out =findText(img);    
    step(vidPlayer,out);
    pause(1/vidReader.FrameRate);
end


