%% Lecture# 7 Morphological Processing
%% Dilation 
clc;clear; close all;
img = imread('F:\AJ Data\img\rectangle.jpg');
SE = [0 1 0; 
      1 1 1; 
      0 1 0];
SE  = ones(25);
out = imdilate(img, SE);
figure, 
subplot(1,2,1),imshow(img,[]),title('Original')
subplot(1,2,2),imshow(out,[]),title('Dilated')
%% Dilation Application
clc;clear; close all;
img = imread('F:\AJ Data\img\text4.jpg');
SE = [0 1 0; 
      1 1 1; 
      0 1 0];
SE  = ones(30,30);
out = imdilate(img, SE);
figure, 
subplot(1,2,1),imshow(img,[]),title('Original')
subplot(1,2,2),imshow(out,[]),title('Dilated')

%% Erosion 
clc;clear; close all;
img = imread('F:\AJ Data\img\rectangle.jpg');
SE = [0 1 0; 
      1 1 1; 
      0 1 0];
SE  = ones(50);
out = imerode(img, SE);
figure, 
subplot(1,2,1),imshow(img,[]),title('Original')
subplot(1,2,2),imshow(out,[]),title('Erosion')

%% Erosion Application
%% Question
clc;clear; close all;
img =imread('F:\AJ Data\img\thumbnail.jpg');
img = rgb2gray(img);
bw = img>(graythresh(img)*255);
figure, 
subplot(2,2,1),imshow(img,[]),title('Original')
subplot(2,2,2),imshow(bw,[]),title('Threshold')

%% Answer
SE = strel('diamond',15);
SE=SE.Neighborhood;
out = imerode(bw, SE);

subplot(2,2,3),imshow(out,[]),title('Erode Result')

%% Opening
clc;clear; close all;
img =imread('blobs.png');
bw = edge(img,'sobel','both');
SE = strel(5,10);
SE=SE.Neighborhood;
out = imopen(bw, SE);

figure, 
subplot(1,2,1),imshow(img,[]),title('Original')
subplot(1,2,2),imshow(out,[]),title('Opening')

%% Closing
clc;clear; close all;
img =imread('blobs.png');
bw = edge(img,'sobel','both');
SE = strel(5,10);
SE=SE.Neighborhood;
out = imclose(bw, SE);

figure, 
subplot(1,2,1),imshow(img,[]),title('Original')
subplot(1,2,2),imshow(out,[]),title('Opening')




%% Hit or Miss Transformation
clc;clear; close all;
img =imread('F:\AJ Data\img\hitmiss.jpg');
img = img>50;
% img = imerode(img,ones(15));
SE1 = strel([ 0 0 0; 
              0 1 1; 
              0 1 0]);
        
SE2= strel([ 1 1 1; 
             1 0 0; 
             1 0 0]);
out = bwhitmiss(img, SE1, SE2);
%
figure, 
subplot(1,2,1),imshow(img,[]),title('Original')
subplot(1,2,2),imshow(out,[]),title('Hit Miss')
%subplot(1,2,2),imshow(imdilate(out,ones(5)),[]),title('Hit Miss')

%% Dilation Erosion Appication
%% Question
clc;clear; close all;
img =imread('F:\AJ Data\img\rectangle.jpg');
img = rgb2gray(img);
SE = ones(3);
imgd = imdilate(img, SE);
out = uint8(imgd - img);
% 
% imge = imerode(img, SE);
% out2 = uint8(img - imge) ;

figure, 
subplot(1,2,1),imshow(img,[]),title('Original')
subplot(1,2,2),imshow(out,[]),title('Dilate - Img')

%% Hole Filling
clc;clear; close all;
img =imread('F:\AJ Data\img\holes.jpg');
img =img>50;
out = imfill(img,'holes');
%
figure, 
subplot(1,2,1),imshow(img,[]),title('Original')
subplot(1,2,2),imshow(out,[]),title('Hole Filling')

%% Remove Small Object
clc;clear; close all;
img =imread('F:\AJ Data\img\holes.jpg');
img =img>50;
out = bwareaopen(img,5000);
%
figure, 
subplot(1,2,1),imshow(img,[]),title('Original')
subplot(1,2,2),imshow(out,[]),title('Hole Filling')

%% Connected Component Labelling
clc;clear; close all;
img =imread('F:\AJ Data\img\coins.jpg');
img = imgaussfilt(img);
bw= img>100;
out = imclose(bw,ones(3));

[L,N] = bwlabel(out);

figure, 
subplot(1,2,1),imshow(img,[]),title('Original')
subplot(1,2,2),imshow(out,[]),title('Binary Image')

%% CC Properties
maxid=0;
summax=0;
for i=1:N
    s = sum(L==i,'all');
    if(s>summax)
        summax=s;
        maxid=i;
    end
end

figure, imshow(L==maxid),title('Biggest')

%% CC Properties
clc;clear; close all;
img =imread('F:\AJ Data\img\coins.jpg');
img = imgaussfilt(img);
bw= img>100;
out = imclose(bw,ones(3));

[L,N] = bwlabel(out);
stats = regionprops(L,'Area','BoundingBox','Centroid','Circularity','ConvexHull');

bbox = stats(1).BoundingBox;

%figure, imshow(img,[])
%hold on

imgcrop = imcrop(img,bbox);
%figure, imshow(imgcrop,[])
figure, imshow(img,[])
hold on;
for i=1:N
    area = stats(i).Area;
    bbox = stats(i).BoundingBox;
    centroid = stats(i).Centroid;
    if(area>2000)
%         bbox = stats(i).BoundingBox;
%         centroid = stats(i).Centroid;
        plot(centroid(1),centroid(2),'or','LineWidth',3);
        rectangle('Position',bbox,'EdgeColor','r','LineWidth',3)
    else
        plot(centroid(1),centroid(2),'og','LineWidth',3);
        rectangle('Position',bbox,'EdgeColor','g','LineWidth',3)
    end
end

%% CC Properties Circular Objects
clc;clear; close all;
img =imread('F:\AJ Data\img\objects.jpg');
img = rgb2gray(img);
out= img<100;
figure, imshow(out,[])

[L,N] = bwlabel(out);
stats = regionprops(L,'Centroid','Circularity','BoundingBox');

figure, imshow(img,[])
hold on;
for i=1:N
    circ = stats(i).Circularity;
   
    if(circ >1)
        bbox = stats(i).BoundingBox;
        centroid = stats(i).Centroid;
        plot(centroid(1),centroid(2),'or','LineWidth',3);
        rectangle('Position',bbox,'EdgeColor','r','LineWidth',3)
    end
end

%% CC Properties Rectangular Objects
clc;clear; close all;
img =imread('F:\AJ Data\img\objects.jpg');
img = rgb2gray(img);
out= img<100;
figure, imshow(out,[])

[L,N] = bwlabel(out);
stats = regionprops(L,'Centroid','Circularity','BoundingBox');

figure, imshow(img,[])
hold on;
for i=1:N
    bbox = stats(i).BoundingBox;
    ar =bbox(3)/bbox(4);
    if(ar>1.0)
        
        centroid = stats(i).Centroid;
        plot(centroid(1),centroid(2),'or','LineWidth',3);
        rectangle('Position',bbox,'EdgeColor','r','LineWidth',3)
    end
end

%% CC Properties Rectangular Objects Filtered using area
clc;clear; close all;
img =imread('F:\AJ Data\img\objects.jpg');
img = rgb2gray(img);
out= img<100;
figure, imshow(out,[])

[L,N] = bwlabel(out);
stats = regionprops(L,'Area','Centroid','Circularity','BoundingBox');

figure, imshow(img,[])
hold on;
for i=1:N
    area = stats(i).Area;
    bbox = stats(i).BoundingBox;
    ar =bbox(3)/bbox(4);
    
    ratio = area/(bbox(3)*bbox(4));
    if(ar>1.0 && ratio>0.99)
        
        centroid = stats(i).Centroid;
        plot(centroid(1),centroid(2),'or','LineWidth',3);
        rectangle('Position',bbox,'EdgeColor','r','LineWidth',3)
    end
end

%% CC Properties Convex Hull
clc;clear; close all;
img =imread('F:\AJ Data\img\hand2.jpg');
gray = rgb2gray(img);
out= gray<240;
figure, imshow(out,[])

[L,N] = bwlabel(out);
stats = regionprops(L,'ConvexHull');

figure, imshow(img,[])
hold on;
for i=1:N
    hul = stats(i).ConvexHull; 
    %hul = unique(hul,'rows');
    plot(hul(:,1),hul(:,2),'*r','LineWidth',1);
end
%ED =  @(p1,p2)sqrt(power(p1(:,1)-p2(:,1),2) +power(p2(:,2)-p2(:,2),2) );
