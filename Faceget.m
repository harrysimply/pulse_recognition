function FaceNum=Faceget(VideoName)

    %人脸个数提取        

    fpath= fullfile(VideoName);
    % Create a cascade detector object.
    faceDetector = vision.CascadeObjectDetector();
    % Read a video frame and run the detector.
    videoFileReader = vision.VideoFileReader(fpath);

    video=VideoReader(fpath);
    videoNum = video.NumberOfFrames;

    videoFrame = step(videoFileReader);
    tempbbox = step(faceDetector, videoFrame);

    boxInserter  = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[255 255 0]);

    % 根据视频第一帧提取结果，裁定脸的个数和各自的大小
    SizeBox=size(tempbbox);
    FaceNum=SizeBox(1);
    disp(['共检测到',num2str(FaceNum),'个对象。']);

    % tempstr=cell(FaceNum,1);
    % for i=1:1:FaceNum
    %     tempstr{i}=['提取第',int2str(i),'个对象'];
    % end
    % set(handles.face_choose,'string',tempstr);%显示提取出脸的个数

    fr=1;  
    for i=1:FaceNum      %记录第一帧提取出各个脸的四个属性
        StartX(i,fr)=tempbbox(i,1);
        StartY(i,fr)=tempbbox(i,2);
        X(i,fr)=tempbbox(i,3);
        Y(i,fr)=tempbbox(i,4);
    end;
    Standardbbox=tempbbox;  %以第一帧的bbox为后续所有帧bbox的标准

    % Create a video player object for displaying video frames.
    videoInfo    = info(videoFileReader);
    videoPlayer  = vision.VideoPlayer('Position',[300 300 videoInfo.VideoSize+30]);

    % 对每一帧视频提取人脸，按照上一步锁定的脸的个数和各自大小
    while ~isDone(videoFileReader)
        fr=fr+1;

        % Extract the next video frame
        videoFrame = step(videoFileReader);
        % RGB -> HSV
        [hueChannel,~,~] = rgb2hsv(videoFrame);

        % Track using the Hue channel data
        %bbox = step(tracker, hueChannel);
        tempbbox = step(faceDetector, videoFrame);

        %根据第一帧所确定的脸的个数和各自大小修正提取结果
        tempSizeBox=size(tempbbox);
        tempFaceNum=tempSizeBox(1);
        bbox=Standardbbox;
        for i=1:FaceNum      %记录第一帧提取出各个脸的四个属性
            FaceFind=0;
            for j=1:tempFaceNum
                if (abs(tempbbox(j,1)-StartX(i,fr-1))<=50) & (abs(tempbbox(j,2)-StartY(i,fr-1))<=50)
                   bbox(i,:)=tempbbox(j,:);
                   FaceFind=1;
                   break;
                end
            end
            if ~FaceFind
                bbox(i,:)=[StartX(i,fr-1),StartY(i,fr-1),X(i,fr-1),Y(i,fr-1)];
            end
        end
        for i=1:FaceNum      %记录这一帧提取出各个脸的四个属性
            StartX(i,fr)=bbox(i,1);
            StartY(i,fr)=bbox(i,2);
            X(i,fr)=bbox(i,3);
            Y(i,fr)=bbox(i,4);
        end   
        % Insert a bounding box around the object being tracked
        videoOut = step(boxInserter, videoFrame, bbox);

        % Display the annotated video frame using the video player object
        step(videoPlayer, videoOut);

    end

    %下面提取出各个人脸，数据存入facedata
    for i=1:FaceNum
       MinX=X(i,1);
       MinY=Y(i,1);
       for fr=2:videoNum
           MinX=min(MinX,X(i,fr));
           MinY=min(MinY,Y(i,fr));
       end

       videoCut = VideoWriter([VideoName(1:end-4),'faceget',num2str(i)]);%初始化一个avi文件
       writerObj.FrameRate = 30;
       open(videoCut);
       for fr=1:videoNum %图像序列个数
          temp=read(video,fr);
          tempx=StartX(i,fr)+0.5*(X(i,fr)-MinX);
          tempy=StartY(i,fr)+0.5*(Y(i,fr)-MinY);
          tempcut=imcrop(temp,[tempx,tempy,MinX,MinY]);
          writeVideo(videoCut,tempcut);
       end 
       close(videoCut);

end