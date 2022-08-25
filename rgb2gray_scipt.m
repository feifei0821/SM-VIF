[imagename1 imagepath1]=uigetfile('selected\VIS\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
image_input1=rgb2gray(imread(strcat(imagepath1,imagename1)));   

figure
imshow(uint8(image_input1));
% imwrite(image_input1,strcat(imagepath1,imagename1));