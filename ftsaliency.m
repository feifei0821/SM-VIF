function [ salFT ] = ftsaliency( img )
% ----------------------
% Author : smh
% Date   : 2017.12.04
% Description:
%   This file including frequency-tuned saliency detection based on
%   'Frequency-tuned Saliency Region Detection' & 'Saliency_CVPR2009.m'
% ----------------------

[m, n, z] = size(img);

% img = im2double(img);

% sigma1=0.1;
% sigma2=1.0;
% window=1;
% H1=fspecial('gaussian', window, sigma1);
% H2=fspecial('gaussian', window, sigma2);
% DiffGauss=H1-H2;
% gfrgb=imfilter(img,DiffGauss, 'symmetric', 'conv');
% gfrgb=mat2gray(gfrgb);

% figure;imshow(uint8(img));
gfrgb = imfilter(img, fspecial('gaussian', 1, 1), 'symmetric', 'conv');
% figure;imshow(uint8(gfrgb));
%---------------------------------------------------------
% Perform sRGB to CIE Lab color space conversion (using D65)
%------------------------------------------x---------------
% cform = makecform('srgb2lab', 'whitepoint', whitepoint('d65'));
if (z == 3)
    cform = makecform('srgb2lab', 'AdaptedWhitePoint', whitepoint('d65'));   % changed by smh
    lab = applycform(gfrgb,cform);
    
    l = double(lab(:,:,1)); lm = mean(mean(l));
    a = double(lab(:,:,2)); am = mean(mean(a));
    b = double(lab(:,:,3)); bm = mean(mean(b));
    
    salFT = (l-lm).^2 + (a-am).^2 + (b-bm).^2;
elseif z == 1
    l = double(gfrgb); lm = mean(mean(1));
    
    salFT = (l-lm).^2;
    salFT = salFT-min(salFT(:));
    salFT = salFT/max(salFT(:));
end

end