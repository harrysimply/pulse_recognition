function Areacut_averaging=Areacut(VideoName,w1,w2,h1,h2,num)
    video=VideoReader(VideoName);
    videoNum = video.NumberOfFrames;% 帧的总数
    
%     videoHeight=video.Height;
%     videoWidth=video.Width;
%     videoColor=3;
    frame01=read(video,1);
%     figure,imshow((squeeze(frame01(:,:,1))))
%     hold on
%     plot(w1,h1,w2,h2, 'r.', 'MarkerSize', 8);
%     plot(w1,h2,w2,h1, 'r.', 'MarkerSize', 8);
%     plot(w2,h1,w1,h2, 'r.', 'MarkerSize', 8);
%     plot(w2,h2,w1,h1, 'r.', 'MarkerSize', 8);
    
    %videoCut = VideoWriter([VideoName(1:end-4),'areacut',num2str(num)]);%初始化一个avi文件
    %writerObj.FrameRate = 30;
    %open(videoCut);
    for fr=1:videoNum %图像序列个数
        temp=read(video,fr);
        tempcut=imcrop(temp,[w1,h1,w2-w1,h2-h1]);
%         

%         绿色通道求平均
        Areacut_averaging(fr)=mean(mean(tempcut(:,:,2)));   

%         %三个通道一起求平均
%         Areacut_averaging(fr)=mean(mean(tempcut(:,:,:)));   
        
% %       %转换为亮度再求平均
%         frame(:,:,fr)= tempcut(:,:,2)*0.299+tempcut(:,:,1)*0.587+tempcut(:,:,3)*0.114;
%         Areacut_averaging(fr)=mean(mean(frame(:,:,fr)));
        
        %writeVideo(videoCut,tempcut);
    end 
	%close(videoCut);
end
