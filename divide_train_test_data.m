load '.\data\train_data.mat'
load '.\data\test_data.mat'
X=mapminmax(train_data(:,1:100)',0,1);
T=mapminmax(test_data(:,1:100)',0,1);
hidden_size =80;
autoenc_1=trainAutoencoder(X,hidden_size,...
    'MaxEpochs',1000,...
    'L2WeightRegularization',0.001,...
    'SparsityRegularization',4,...
    'SparsityProportion',0.05,...
    'DecoderTransferFunction','purelin');

XReconstructed = predict(autoenc_1,X);
mseError = mse(X-XReconstructed)


features_1 =encode(autoenc_1,X);



hidden_size_2=50;
autoenc_2=trainAutoencoder(features_1,hidden_size_2,...
    'L2WeightRegularization',0.001,...
    'SparsityRegularization',4,...
    'SparsityProportion',0.05,...
    'DecoderTransferFunction','purelin');

features_2=encode(autoenc_2,features_1);

hidden_size_3=25;
autoenc_3=trainAutoencoder(features_2,hidden_size_3,...
    'L2WeightRegularization',0.001,...
    'SparsityRegularization',4,...
    'SparsityProportion',0.05,...
    'DecoderTransferFunction','purelin');

features_3=encode(autoenc_3,features_2);

autoenc=stack(autoenc_1,autoenc_2,autoenc_3);
view(autoenc);
res_train=autoenc(X);
res_test=autoenc(T);
save('.\data\res_test_data.mat','res_test')
save('.\data\res_train_data.mat','res_train')



figure(1)
h=plotWeights(autoenc_1);
figure(2)
h_2=plotWeights(autoenc_2);
figure(3)
h_3=plotWeights(autoenc_3);






