function F=enhance_fuse(A,B)
%clear all;
% close all;
% clc;

% addpath(genpath('dtcwt_toolbox'));
% addpath(genpath('fdct_wrapping_matlab'));
% addpath(genpath('nsct_toolbox'));
% addpath(genpath('evalution'));
% addpath(genpath('guidedImageFilter-master'));
% 
% [imagename1 imagepath1]=uigetfile('source_images\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
% image_input1=imread(strcat(imagepath1,imagename1));    
% [imagename2 imagepath2]=uigetfile('source_images\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
% image_input2=imread(strcat(imagepath2,imagename2));    

% image_input1=imread('source_images\261.bmp');    
% image_input2=imread('source_images\262.bmp');    
% image_input1=imread('source_images\FLIR_000061.jpg');    
% image_input2=imread('source_images\FLIR_000062.jpg');   

% A=double(image_input1);
% B=double(rgb2gray(image_input2));

% figure;imshow(image_input1);
% figure;imshow(image_input2);

% if size(image_input1)~=size(image_input2)
%     error('two images are not the same size.');
% end

level=1;
% A=double(rgb2gray(image_input1));
% B=double(rgb2gray(image_input2));
% A=double(image_input1);
% B=double(image_input2);

% D_A=phasecong2(A);
% A=A-D_A;

for i=1:level
    D_A(:,:,i)=ftsaliency(A).*A;
%     figure;imshow(uint8(D_A(:,:,i)));
    A=A-D_A(:,:,i);
%     figure;imshow(uint8(A));

    
    D_B(:,:,i)=ftsaliency(B).*B;
%     figure;imshow(uint8(D_B(:,:,i)));
    B=B-D_B(:,:,i);
%     figure;imshow(uint8(B));
    
    D_F(:,:,i)=selb(D_A(:,:,i),D_B(:,:,i),4);
    
%     figure;imshow(uint8(D_F(:,:,i)));
%     imwrite(uint8(D_F(:,:,i)),'fusesalient1.jpg')
end

% imwrite(uint8(A),'B_IR.jpg');
% imwrite(uint8(B),'B_VIS.jpg');
% figure;imshow(uint8(A));
% figure;imshow(uint8(B));
B_F=fuse_difference(A,B);
% B_F=selc(A,B,5);
% B_F=GTF_fuse(B,A);
% B_F=A;
% B_F=B;
% figure;imshow(uint8(B_F));

for i=1:level
    F=D_F(:,:,i);
end

F=F+B_F;

% figure;imshow(D_A);
% figure;imshow(A);
% figure;imshow(uint8(F));
% imwrite(uint8(F),'fused2.jpg');
% figure;imshow(B);