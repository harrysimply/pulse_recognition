git function [x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6] = area_location(Facename)

% faceDetector = vision.CascadeObjectDetector();
% 
videoFileReader = vision.VideoFileReader(Facename);
videoFrame      = step(videoFileReader);
% bbox            = step(faceDetector, videoFrame);
length = size(videoFrame,2);%水平方向
width = size(videoFrame,1);
bbox = [1,1,length-1,width-1];
% videoFrame = insertShape(videoFrame, 'Rectangle', bbox);
% figure; imshow(videoFrame); title('Detected face');

% bboxPoints = bbox2points(bbox(1, :));

points = detectMinEigenFeatures(rgb2gray(videoFrame), 'ROI', bbox);

%==================不用显示检测人脸与点数=========================%
% figure, imshow(videoFrame), hold on, title('Detected features');
% plot(points);

pointTracker = vision.PointTracker('MaxBidirectionalError', 2);

points = points.Location;
numPoints = size(points,1);
minPoints = min(points);
maxPoints = max(points);
minX = minPoints(1,1);%以水平向右为x，垂直向下为y
maxX = maxPoints(1,1);
minY = minPoints(1,2);
maxY = maxPoints(1,2);
mediumX = (maxX-minX)/2 + minX;
mediumY = (maxY-minY)/2 + minY;
numleftface = 0;
numlefteye = 0;
%下面修改过
% numrighteye = 0; 

numleftnose = 0;
numrightnose = 0;
rowleftface=1;
rowlefteye=1;
rowleftnose=1;
rowrightnose=1;

%给下面要用到的矩阵赋初值
[m,n]=size(points);
rightnose=zeros(m,n);

for i=1:(numPoints-1)
    if (points(i+1,1)-points(i,1)<10) && (points(i,1)<minX+25)
        leftface(rowleftface,:) = points(i,:);
        rowleftface = rowleftface + 1;
        continue;
    elseif (points(i+1,1)-points(i,1)<10) && (points(i,1)<mediumX) && (points(i,1)>mediumX-40) && (points(i,2)<mediumY)
        lefteye(rowlefteye,:) = points(i,:);
        rowlefteye = rowlefteye + 1;
        continue;
%     elseif (points(i+1,1)-points(i,1)<10) && (points(i,1)<mediumX) && (points(i,1)>mediumX-30) && (points(i,2)>mediumY) && (points(i,2)<maxY-40)
%         leftnose(rowleftnose,:) = points(i,:);
%         rowleftnose = rowleftnose + 1;
%         continue;
    elseif (points(i+1,1)-points(i,1)<10) && (points(i,1)>mediumX) && (points(i,1)<mediumX+30) && (points(i,2)>mediumY) && (points(i,2)<maxY-40)
        rightnose(rowrightnose,:) = points(i,:);
       rowrightnose = rowrightnose + 1;
       
%     elseif (points(i+1,1)-points(i,1)<10) && (points(i,1)>mediumX) && (points(i,1)<mediumX+40) && (points(i,2)>minY+25) && (points(i,2)<minY+55)
%         righteye(i-numleftface-numlefteye-numleftnose-numrightnose,:) = points(i,:);
%         numrighteye = numrighteye + 1;
%         continue;
    else
      continue;  
    end
end

leftoutline = max(leftface(:,1));
topoutline = max(lefteye(:,2));

%  meleftoutline = min(leftnose(:,1));
merightoutline = max(rightnose(:,1));
%（x1,y1）代表左1点（眉心一点）
x1 = leftoutline + 50 - bbox(1,1);
y1 = topoutline - 40 - bbox(1,2);
%（x2,y2）代表左2点
x2 = leftoutline + 20 - bbox(1,1);
y2 = topoutline+30 - bbox(1,2);
%(x5,y5)对应左3个点
x5 = leftoutline +15 - bbox(1,1);
% y5 = meleftoutline+70-bbox(1,2);
y5 = maxY -35 - bbox(1,2);
%（x3,y3）对应右1点
x3 = merightoutline+24 - bbox(1,1);
y3 = topoutline + 15 - bbox(1,2);
%（x4,y4）对应右2点
x4 = merightoutline +36- bbox(1,1);
y4 = topoutline + 32 - bbox(1,2);

%（x6,y6）对应右3
x6 = merightoutline +30 - bbox(1,1);
y6 = maxY -41 - bbox(1,2);
%在眉心点一个点
% x7 = meleftoutline+20-bbox(1,1);%减号代表向左移
% y7 = topoutline-50-bbox(1,2);

%=====================不用点出来点============%
% plot(x1,y1, 'r.', 'MarkerSize', 8);
% plot(x2,y2, 'r.', 'MarkerSize', 8);
% plot(x3,y3, 'r.', 'MarkerSize', 8);
% plot(x4,y4, 'r.', 'MarkerSize', 8);
% plot(x5,y5, 'r.', 'MarkerSize', 8);
% plot(x6,y6, 'r.', 'MarkerSize', 8);
% plot(x7,y7, 'r.', 'MarkerSize', 8);
end