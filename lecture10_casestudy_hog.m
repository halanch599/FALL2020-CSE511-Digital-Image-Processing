%% Face recognition using HOG features and SVM
%% Clear data
clear;
clc;
close all;

%% Load Data
dataFolder='F:\AJ Data\Data\yalefaces_preproessed\';

imds =  imageDatastore(dataFolder,'IncludeSubFolders',true,'LabelSource','foldernames');
imds.ReadFcn = @(im)imresize(imread(im),[256 256]);

[imdsTrain, imdsTest] =   splitEachLabel(imds,0.8);

N = length(imdsTrain.Files);
idx = randi(N,[1,4]);

figure, 
subplot(2,2,1),imshow(readimage(imdsTrain,idx(1)),[])
subplot(2,2,2),imshow(readimage(imdsTrain,idx(2)),[])
subplot(2,2,3),imshow(readimage(imdsTrain,idx(3)),[])
subplot(2,2,4),imshow(readimage(imdsTrain,idx(4)),[])

%% Data Summerizaation
countEachLabel(imdsTrain)
countEachLabel(imdsTest)

%% Extract HOG Feature for Training dataset
img = readimage(imdsTrain,1);
[featureVector,hogVisualization] = extractHOGFeatures(img,'CellSize',[16 16], ...
'BlockSize',[4 4]);

figure;
imshow(img); 
hold on;
plot(hogVisualization,'color','r');

hogFeatureSize =length(featureVector); 
%% featuer for training
numImages = length(imdsTrain.Files);
trainingFeatures = zeros(numImages,hogFeatureSize,'single');
for i=1:numImages
    img = readimage(imdsTrain,i);
    trainingFeatures(i,:) = extractHOGFeatures(img,'CellSize',[16 16], 'BlockSize',[4 4]);
end

trainingLabels = imdsTrain.Labels;

%% Train SVM Classifier
%model = fitcecoc(trainingFeatures,trainingLabels);
model  =fitcensemble(trainingFeatures,trainingLabels);
%% Feature extraction testing
numImages = length(imdsTest.Files);
testingFeatures = zeros(numImages,hogFeatureSize,'single');
for i=1:numImages
    img = readimage(imdsTest,i);
    testingFeatures(i,:) = extractHOGFeatures(img,'CellSize',[16 16], 'BlockSize',[4 4]);
end

testLabels = imdsTest.Labels;

%% Evaluation
predictedLabels = predict(model,testingFeatures);

plotconfusion(testLabels,predictedLabels);

stats =  confusionmatStats(testLabels,predictedLabels);










