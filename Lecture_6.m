%% Thresholding
close all;
clear;
clc;
img= imread('F:\AJ Data\img\shape3.jpg');
figure, 
T = graythresh(img)*255;
subplot(1,2,1),imshow(img,[]), title('Original')
subplot(1,2,2),imshow(img>T,[]), title(['Threshold = ',num2str(T)])

%% Histogram based thresholding
close all;
clear;
clc;
img= imread('F:\AJ Data\img\circle1.jpg');
h = imhist(img);
hsorted= sort(h,'descend');
maxid1 = find(h==hsorted(1));
maxid2 = find(h==hsorted(2));
thresh = maxid1 + (maxid2-maxid1)/2;
figure, plot(h)
figure, imshow(imcomplement(img>thresh),[])
figure, imshow(img,[])

%% Global Thresholding: Problem
close all;
clear;
clc;

img = imread('printedtext.png');
figure, 
subplot(1,2,1),imshow(img,[]),title('Original')
subplot(1,2,2),imshow(imbinarize(img,graythresh(img)),[]),title('Global Thresholding')
%% Adaptive Thresholding
img = imread('printedtext.png');
T = adaptthresh(img,0.3,'ForegroundPolarity','dark');
BW = imbinarize(img,T);
%figure, imshow(T), title('Estimate of background')
figure, 
subplot(1,2,1),imshow(img,[]),title('Original')
subplot(1,2,2),imshow(BW),title('Global Thresholding')

%% point Detection 
close all; clear; clc;
img = rgb2gray(imread('F:\AJ Data\img\irregular6.JPG'));
kernel = [-1 -1 -1; 
          -1  8 -1; 
          -1 -1 -1];
out = abs(imfilter(double(img), kernel));
T = max(out(:));
out = out >= T-10;
out = imdilate(out,ones(9,9));
figure, 
subplot(1,2,1),imshow(img,[]),title('Original')
subplot(1,2,2),imshow(out,[]),title('Point')
%% Edge Detection
close all; clear; clc;
img = im2double(imread('coins.png'));
imshow(img,[]),title('Original')
kernel =[-1 -2 -1;
          0  0  0;
          1  2  1];
% kernel =[-1  -1 -1;
%          -1   0  1;
%           0   1  1];
Gx = imfilter(img,kernel);
Gy = imfilter(img,kernel');
figure, imshow(abs(Gx),[]),title('Gx')
figure, imshow(abs(Gy),[]),title('Gy')
% mangnitude
mag = sqrt(Gx.*Gx + Gy.*Gy);
theta = atan2(Gy,Gx);
figure, imshow(mag,[]),title('Magnitude')
figure, imshow(theta,[]),title('Gradients')
quiver(mag,theta);

%% Edge Mag and Direction Built-in
close all; clear; clc;
I = imread('coins.png');
[Gmag, Gdir] = imgradient(I,'sobel');
figure,
imshowpair(Gmag, Gdir, 'montage');
title('Gradient Magnitude, Gmag (left), and Gradient Direction, Gdir (right), using Prewitt method')
quiver(Gmag,Gdir);
%% Edge Detection Built-in
I = imread('coins.png');
figure
method = 'Sobel';
BW = edge(I,method);
subplot(2,3,1),imshow(BW,[]),title(method);
method = 'Prewitt';	
BW = edge(I,method);
subplot(2,3,2),imshow(BW,[]),title(method);
method = 'Roberts';
BW = edge(I,method);
subplot(2,3,3),imshow(BW,[]),title(method);
method = 'Canny';
BW = edge(I,method);
subplot(2,3,4),imshow(BW,[]),title(method);
method = 'log';
BW = edge(I,method);
subplot(2,3,5),imshow(BW,[]),title(method);
method='zerocross';
BW = edge(I,method);
subplot(2,3,6),imshow(BW,[]),title(method);

%% Edge detection 3D Volume
volData = load('mri');
sz = volData.siz;
vol = squeeze(volData.D);
[Gmag, Gaz, Gelev] = imgradient3(vol);
figure, 
montage(reshape(Gmag,sz(1),sz(2),1,sz(3)),'DisplayRange',[])
title('Gradient magnitude')
%% 
img = imread('F:\AJ Data\img\irregular6.JPG');
figure, imshow(img,[])
h = images.roi.Line(gca,'Position',[1 285;596 283]);


%% COlor image Thresholding
close all; clear; clc;

img= imread('F:\AJ Data\img\applesorages.jpg');
figure, imshow(img,[]), title('Rectangle')
rect = getrect;

imgapple = imcrop(img,rect);
figure, imshow(imgapple);
offset= 10;
Rmin = min(min(imgapple(:,:,1)))-offset;
Rmax = max(max(imgapple(:,:,1)))+offset;

Gmin = min(min(imgapple(:,:,2)))-offset;
Gmax = max(max(imgapple(:,:,2)))+offset;

Bmin = min(min(imgapple(:,:,3)))-offset;
Bmax = max(max(imgapple(:,:,3)))+offset;

red = img(:,:,1);
green = img(:,:,2);
blue = img(:,:,3);

figure, 
subplot(2,3,1),imshow(red,[]), title('Red')
subplot(2,3,2),imshow(green,[]), title('Green')
subplot(2,3,3),imshow(blue,[]), title('Blue')

maskr = ~(red >= Rmin & red <= Rmax);
red(maskr) = 0;

maskg = ~(green >= Rmin & green<= Rmax);
green(maskg) = 0;

maskb = ~(blue >= Rmin & blue <= Rmax);
blue(maskb) = 0;


subplot(2,3,4),imshow(red,[]), title('Red')
subplot(2,3,5),imshow(green,[]), title('Green')
subplot(2,3,6),imshow(blue,[]), title('Blue')
% hred = imhist(red);
% hgreen = imhist(green);
% hblue = imhist(blue);

% figure, plot(hred),title('red')
% figure, plot(hgreen),title('green')
% figure, plot(hblue),title('blue')
% 
% figure, imshow(img,[])
% 
% imtool(img);

%% Texture and Edge Feature
close all;
clear;
clc;
img = imread('F:\AJ Data\img\shape3.jpg');
figure, 
subplot(1,2,1),imshow(img,[]), title('Original')
T = graythresh(img)*255;
out = img>T;
subplot(1,2,2),imshow(out,[]), title(['BW T=', num2str(T)])

%% Connected Components
close all; clear; clc;
I = imread('coins.png');
BW =  I>100;
[L, N] = bwlabel(BW);
figure, imshow(BW,[])
return;
blobSum=10000;
bigId=-1;
 for i=1:N
     s = sum(sum(L==i));
     if(s<blobSum)
         blobSum=s;
         bigId=i;
     end
 end
if(bigId>-1)
    figure, imshow(L==bigId,[]),title('Biggest Object')
end