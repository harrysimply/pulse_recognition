function res = compare_data(sample,pattern,mode)

    if strcmp( mode,'cosine')

        %计算余弦相似度
        A=sqrt(sum(sum(sample.^2)));
        B=sqrt(sum(sum(pattern.^2)));
        C=sum(sum(sample.*pattern));

        cos_value=C/(A*B);

        %cos_arc=acos(cos_value)%弧度
        %v=cos_arc*180/pi%角度

        res=cos_value;
   
    elseif strcmp(mode,'euclidean')
        
        
        %计算欧氏距离(两个比较向量列要相同)
        X=[sample;pattern];
        res=pdist(X,'seuclidean');
    end
end







