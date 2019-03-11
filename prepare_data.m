%输入脸部视频
%将人脸视频先定位6个点，再根据6个点每个点分五块皮肤，每块皮肤像素绿色通道取平均得到30段序列，划分训练集与测试集保存

clc
clear
addpath('.\脸部视频')
num=1;
row=1;
face_num=1;
total_face_num=30;%修改总的人脸个数

total_sample_num=30;%y样本
train_sample_num=20 ;
test_sample_num=10;

% data=zeros(total_sample_num*total_face_num,5000);
% train_data=zeros(20*total_face_num,5000);
% test_data=zeros(10*total_face_num,5000);

for i = 1:total_face_num
    if i>9 && i< 100
        video_name=['00',num2str(i),'.mp4'] 
    elseif i<9
        video_name=['000',num2str(i),'.mp4']
    elseif i>99
        video_name=['0',num2str(i),'.mp4']
    end
   
    facename=[video_name(1:end-4),'faceget',num2str(face_num),'.avi'];
    %找到6个基准点
    [x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6] = area_location(facename);
   
    %单个人脸部20个训练样本
    %Areacut_averaging1=Areacut(facename,x1,x1+20,y1,y1+15,01);
    Areacut_averaging1=Areacut(facename,x1,x1+1,y1,y1+1,01);
    Areacut_averaging2=Areacut(facename,x1+2,x1+22,y1+2,y1+17,02);
    Areacut_averaging3=Areacut(facename,x1-2,x1+18,y1-2,y1+13,03);
    Areacut_averaging4=Areacut(facename,x1+2,x1+22,y1-2,y1+13,04);
    Areacut_averaging5=Areacut(facename,x1-2,x1+18,y1+2,y1+17,05);

    Areacut_averaging6=Areacut(facename,x2,x2+20,y2,y2+15,06);
    Areacut_averaging7=Areacut(facename,x2+2,x2+22,y2+2,y2+17,07);
    Areacut_averaging8=Areacut(facename,x2-2,x2+18,y2-2,y2+13,08);
    Areacut_averaging9=Areacut(facename,x2+2,x2+22,y2-2,y2+13,09);
    Areacut_averaging10=Areacut(facename,x2-2,x2+18,y2+2,y2+17,10);

    Areacut_averaging11=Areacut(facename,x3,x3+20,y3,y3+15,11);
    Areacut_averaging12=Areacut(facename,x3+2,x3+22,y3+2,y3+17,12);
    Areacut_averaging13=Areacut(facename,x3-2,x3+18,y3-2,y3+13,13);
    Areacut_averaging14=Areacut(facename,x3+2,x3+22,y3-2,y3+13,14);
    Areacut_averaging15=Areacut(facename,x3-2,x3+18,y3+2,y3+17,15);

    Areacut_averaging16=Areacut(facename,x4,x4+20,y4,y4+15,16);
    Areacut_averaging17=Areacut(facename,x4+2,x4+22,y4+2,y4+17,17);
    Areacut_averaging18=Areacut(facename,x4-2,x4+18,y4-2,y4+13,18);
    Areacut_averaging19=Areacut(facename,x4+2,x4+22,y4-2,y4+13,19);
    Areacut_averaging20=Areacut(facename,x4-2,x4+18,y4+2,y4+17,20);    
    
    %单个人脸部10个测试样本
    Areacut_averaging21=Areacut(facename,x5,x5+20,y5,y5+15,21);
    Areacut_averaging22=Areacut(facename,x5+2,x5+22,y5+2,y5+17,22);
    Areacut_averaging23=Areacut(facename,x5-2,x5+18,y5-2,y5+13,23);
    Areacut_averaging24=Areacut(facename,x5+2,x5+22,y5-2,y5+13,24);
    Areacut_averaging25=Areacut(facename,x5-2,x5+18,y5+2,y5+17,25);
   
    Areacut_averaging26=Areacut(facename,x6,x6+20,y6,y6+15,26);
    Areacut_averaging27=Areacut(facename,x6+2,x6+22,y6+2,y6+17,27);
    Areacut_averaging28=Areacut(facename,x6-2,x6+18,y6-2,y6+13,28);
    Areacut_averaging29=Areacut(facename,x6+2,x6+22,y6-2,y6+13,29);
    Areacut_averaging30=Areacut(facename,x6-2,x6+18,y6+2,y6+17,30);
    
     
    %生成训练样本集
    temp=Areacut_averaging1;
    temp(1,5000)=0;
    train_data(1+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging2;
    temp(1,5000)=0;
    train_data(2+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging3;
    temp(1,5000)=0;
    train_data(3+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging4;
    temp(1,5000)=0;
    train_data(4+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging5;
    temp(1,5000)=0;
    train_data(5+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging6;
    temp(1,5000)=0;
    train_data(6+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging7;
    temp(1,5000)=0;
    train_data(7+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging8;
    temp(1,5000)=0;
    train_data(8+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging9;
    temp(1,5000)=0;
    train_data(9+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging10;
    temp(1,5000)=0;
    train_data(10+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging11;
    temp(1,5000)=0;
    train_data(11+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging12;
    temp(1,5000)=0;
    train_data(12+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging13;
    temp(1,5000)=0;
    train_data(13+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging14;
    temp(1,5000)=0;
    train_data(14+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging15;
    temp(1,5000)=0;
    train_data(15+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging16;
    temp(1,5000)=0;
    train_data(16+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging17;
    temp(1,5000)=0;
    train_data(17+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging18;
    temp(1,5000)=0;
    train_data(18+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging19;
    temp(1,5000)=0;
    train_data(19+(row-1)*train_sample_num,:)=temp;
    temp=Areacut_averaging20;
    temp(1,5000)=0;
    train_data(20+(row-1)*train_sample_num,:)=temp;
    
    %生成测试样本集
    temp=Areacut_averaging21;
    temp(1,5000)=0;
    test_data(1+(row-1)*test_sample_num,:)=temp;
    temp=Areacut_averaging22;
    temp(1,5000)=0;
    test_data(2+(row-1)*test_sample_num,:)=temp;
    temp=Areacut_averaging23;
    temp(1,5000)=0;
    test_data(3+(row-1)*test_sample_num,:)=temp;
    temp=Areacut_averaging24;
    temp(1,5000)=0;
    test_data(4+(row-1)*test_sample_num,:)=temp;
    temp=Areacut_averaging25;
    temp(1,5000)=0;
    test_data(5+(row-1)*test_sample_num,:)=temp;
    temp=Areacut_averaging26;
    temp(1,5000)=0;
    test_data(6+(row-1)*test_sample_num,:)=temp;
    temp=Areacut_averaging27;
    temp(1,5000)=0;
    test_data(7+(row-1)*test_sample_num,:)=temp;
    temp=Areacut_averaging28;
    temp(1,5000)=0;
    test_data(8+(row-1)*test_sample_num,:)=temp;
    temp=Areacut_averaging29;
    temp(1,5000)=0;
    test_data(9+(row-1)*test_sample_num,:)=temp;
    temp=Areacut_averaging30;
    temp(1,5000)=0;
    test_data(10+(row-1)*test_sample_num,:)=temp;
    
    num=num+1;
    row=row+1;
    
end
 save('.\data\train_data_30.mat','train_data')
  save('.\data\test_data_30.mat','test_data')
