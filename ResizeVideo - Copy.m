video=VideoReader('Video.avi');
Outputvideo=VideoWriter('Video_20.avi');
Outputvideo.FrameRate=video.FrameRate;
open(Outputvideo);
%%Use resize function for resizing the output video
while hasFrame(video)
    frame=readFrame(video);
    resizedFrame=imresize(frame,[1080,1920]);
    writeVideo(Outputvideo, resizedFrame);
end
close(Outputvideo);