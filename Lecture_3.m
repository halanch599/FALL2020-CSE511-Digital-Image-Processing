%% Pixel Range Values In Image
clear;
clc;
close all;

% change the range of image from [0- 255] =>[0 1]
img = imread('F:\AJ Data\img\breast.jpg');
img = rgb2gray(img);

%img =im2double(img);

%out  = mx-img;
out = mat2gray(img);
out2 = im2uint8(out);
disp([min(img(:)) max(img(:))])
disp([min(out(:)) max(out(:))])
disp([min(out2(:)) max(out2(:))])
figure, 
subplot(1,3,1),imshow(img,[]), title('Original')
subplot(1,3,2),imshow(out,[]), title('Adjusted')
subplot(1,3,3),imshow(out2,[]), title('Output 2')

%% Point Processing
clear;
clc;
close all;

% change the range of image from [0- 255] =>[0 1]
img = imread('F:\AJ Data\img\breast.jpg');
img = rgb2gray(img);
% 0 - 255 
out = img + 100;
figure, 
subplot(1,2,1),imshow(img,[]), title('Original')
subplot(1,2,2),imshow(out,[]), title('Ouput')

%% Image Negative
clear;
clc;
close all;
img = imread('F:\AJ Data\img\breast.jpg');
img = rgb2gray(img);

%img= mat2gray(img);
%mx=1;
%mx=255;
%mx =max(img(:));
%out  = mx-img;
out = imcomplement(img);
figure, 
subplot(1,2,1),imshow(img,[]), title('Original')
subplot(1,2,2),imshow(out,[]), title('Adjusted')
%% Functions imadj ust and stretchlim Function 
%g = imadjust( f , [ low_in h ig h_in ] , [ low_o ut high_out ] , g amma )
clear;
clc;
close all;

img = imread('F:\AJ Data\img\breast.jpg');
img = rgb2gray(img);
%out = imadjust(img,[],[], 0.5  );

out = imadjust(img,stretchlim(img),[0 1]  );
figure, 
subplot(1,2,1),imshow(img,[]), title('Original')
subplot(1,2,2),imshow(out,[]), title('Adjusted')


%% Log Transform
clear;
clc;
close all;

%g = c * log ( 1 + f )
img = imread('F:\AJ Data\img\breast.jpg');
img = rgb2gray(img);
c=5;

out = c*log(1+mat2gray(img));
out = im2uint8(out);
figure, 
subplot(1,2,1),imshow(img,[]), title('Original')
subplot(1,2,2),imshow(out,[]), title('Adjusted')

%% Thresholding
clear;
clc;
close all;


img = imread('F:\AJ Data\img\breast.jpg');
img = rgb2gray(img);
T = graythresh(img)*255;
%T=200;

out = img<T;
%out = imbinarize(img,T);

figure,imshowpair(img,out,'montage')


%% Histogram 
clear;
clc;
close all;


img = imread('F:\AJ Data\img\breast.jpg');
img = rgb2gray(img);
out = imhist(img);

figure, 
subplot(1,2,1),imshow(img,[]),title('Original');



subplot(1,2,2),plot(out,'-r')
hold on
out1 = imhist(img+50);
plot(out1,'--b')
grid on

%% Histogram Application 
clear;
clc;
close all;


img = imread('F:\AJ Data\img\overlaped.png');
img = rgb2gray(img);
figure,imshow(img<70,[])
out = imhist(img);
figure,plot(out,'-r')

grid on

%% Power Law
clear;
clc;
close all;

%s = c * r^gamma
c=1;
gamma =0.5;
file = 'F:\AJ Data\img\tyre.jpg';
%file = 'F:\AJ Data\img\breast.jpg';
img = imread(file);
img = rgb2gray(img);
img = mat2gray(img);
out = c*img.^gamma;
out =  im2uint8(out);
figure,imshowpair(img,out,'montage')

%% Power Law Histogram
h1 = imhist(img);
h2 = imhist(out);
figure, plot(h1,'-r');
hold on
plot(h2,'--b');
grid on
legend('Original Hist','Transformed Hist');

%% Convolution && Correlation
img = imread('F:\AJ Data\img\coins.jpg');
hsize = 7;
%h=ones(hsize )/(hsize *hsize );
%h = fspecial('average',hsize);
% h = fspecial('disk',1);
 h = fspecial('gaussian',hsize,1.0);
%out= imfilter(img, h,'corr'); % default
out= imfilter(img, h,'conv');
figure,imshowpair(img,out,'montage')