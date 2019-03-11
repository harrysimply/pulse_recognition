%输入是截取的原始视频
%输出是人脸avi视频

clc
clear
addpath('.\原始样本')


for i=1:5
    if i>9 && i <100
   videoname=['00',num2str(i),'.mp4'] 
    elseif i>99
      videoname=['0',num2str(i),'.mp4']  
    elseif i<9
        videoname=['000',num2str(i),'.mp4'] 
    end
   
    Faceget(videoname);
end
    