function out= findText(I)
%Detect the text
img = im2double(I);
imgray = rgb2gray(img);
imgray = imgaussfilt(imgray);
imgSobel=  edge(imgray,'Sobel','both');
hedges = imerode(imgSobel,ones(1,50));
vedges = imerode(imgSobel,ones(50,1));
imgSobel(hedges)=0;
imgSobel(vedges)=0;

SE = ones(1,11);
imgDilted =imdilate(imgSobel,SE);
imgprocessed = bwareaopen(imgDilted,500);

[L,N] = bwlabel(imgprocessed);
if(N==0)
    return;
end

stats =  regionprops(L,'Area','BoundingBox');

areas = [stats.Area];
bboxes= {stats.BoundingBox};

idx = find(areas<300);
areas(idx)=[];
bboxes(idx)=[];

out = uint8(zeros(size(imgprocessed)));
out=I;
for i=1:length(areas)
    area = areas(i);
    bbox = bboxes{i};
    ar = bbox(3)/bbox(4);
    %out = insertShape(out,'rectangle', bbox,'LineWidth',3,'Color',{'green'});
    if(ar>1.30 && bbox(4)>10 && bbox(4)<120 && bbox(3)>15)
       out = insertShape(out,'rectangle', bbox,'LineWidth',3,'Color',{'green'});
       cropped = imcrop(I,bbox);
      ocrText =  ocr(cropped,'Language','Turkish','TextLayout','Block');
      disp(ocrText.Text);
    end
end
%out=imgprocessed;
end

