a=VideoReader('Video_20.avi');
n=1;
while hasFrame(a)
    img=readFrame(a); 
    imwrite(img,strcat('num',num2str(n),'.png'));
    n=n+1;
end
n=n-1;
disp('images have been extracted from video'); 
