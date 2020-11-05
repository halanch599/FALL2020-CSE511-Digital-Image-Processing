%% Histogram Processing
clear;
clc;
close all;

% change the range of image from [0- 255] =>[0 1]
img = imread('F:\AJ Data\img\breast.jpg');
img = rgb2gray(img);
b=256;
figure, 
subplot(1,2,1), imshow(img,[]),title('Original Image')
subplot(1,2,2), imhist(img,b),title('Histogram')
grid on
%% bar

b=64;
x = linspace(0, 255, b);
h = imhist(img, b);
figure,
bar(x, h);
grid on

%% Stem
figure, stem(x,h,'filled' ); 
grid on


%% Normalized histogram
b=32;
p = imhist(img, b)/numel(img);
x = linspace(0, 255, b);
figure,
bar(x, p),title('Normalized Histogram');
grid on

%% Contrast Stretchin
clear;
clc;
close all;
img = imread('pout.tif');
figure,
subplot(2,2,1),imshow(img)
subplot(2,2,3),imhist(img)
J = imadjust(img,stretchlim(img),[]);
subplot(2,2,2),imshow(J)
subplot(2,2,4),imhist(J)

%% Histogram Equalization
clear;
clc;
close all;

img = imread('F:\AJ Data\img\grain2.jpg');
img = rgb2gray(img);
figure,
subplot(2,2,1),imshow(img),title('Original')
subplot(2,2,3),imhist(img)
J = histeq(img, 256);
subplot(2,2,2),imshow(J),title('Hist Equalization')
subplot(2,2,4),imhist(J)


%% Normalized histogram and CDF.
clear;
clc;
close all;
img = imread('F:\AJ Data\img\grain2.jpg');
img = rgb2gray(img);

hnorm = imhist(img)./numel(img); 
cdf = cumsum(hnorm); % CDF.
% Intervals for [0,1] x scale.
x = linspace(0, 1, 256); 
figure, plot(x, cdf), grid on