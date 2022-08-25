addpath(genpath('nsct_toolbox'));
addpath(genpath('evalution'));
addpath(genpath('GTF-master'));
addpath(genpath('LIME-master'));
addpath(genpath('Low-light-image-enhancement-master'));

[imagename1 imagepath1]=uigetfile('source_images\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
image_input1=imread(strcat(imagepath1,imagename1));    
[imagename2 imagepath2]=uigetfile('source_images\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
image_input2=imread(strcat(imagepath2,imagename2));    

% figure;imshow(image_input1);
% figure;imshow(image_input2);
[m,n]=size(image_input1);

% if size(image_input1)~=size(image_input2)
%     error('two images are not the same size.');
% end


% A=double(rgb2gray(image_input1));
B=double(rgb2gray(image_input2));
A=double(image_input1);
% B=double(image_input2);

tic

% C=enhance_fuse(A,B);
C=lp_fuse(A,B,1,1,3);

toc

figure
imshow(uint8(C));