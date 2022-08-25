% function Y=visible_enhance(A)

% addpath(genpath('dtcwt_toolbox'));
% addpath(genpath('Hybrid-MSD Fusion'));
% addpath(genpath('fdct_wrapping_matlab'));
% addpath(genpath('nsct_toolbox'));
% addpath(genpath('evalution'));
addpath(genpath('GTF-master'));
% addpath(genpath('guidedImageFilter-master'));
% addpath(genpath('image-fusion-evaluation-master'));
% addpath(genpath('imagefusion_Infrared_visible_latlrr-master'));
% addpath(genpath('Image-fusion-with-VSM-and-WLS-master'));
[imagename1 imagepath1]=uigetfile('source_images\visible-infrared\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
image_input1=imread(strcat(imagepath1,imagename1)); 
% 
% % figure;imshow(image_input1);
% % figure;imshow(image_input2);
% 
A=double(image_input1)/255;
% figure;imshow(A);

[m,n]=size(A);%获取矩阵大小

A_out=TIP_enhance(A*255);%直方图均衡化
% A_out=LIME_enhance(A);%直方图均衡化
% A_out=guidedfilter(A,A_out,5,0.1);
% A_out=vis_enhance(A*255);%直方图均衡化
% A_out=A+0.5;
% figure;imshow(A_out);

% sigma = 100;
% gausFilter = fspecial('gaussian', [5,5], sigma);
% A_out= imfilter(A_out, gausFilter, 'replicate');
% figure;imshow(A_out);


nmpdef;
pars_irn = irntvInputPars('l1tv');

pars_irn.adapt_epsR   = 1;
pars_irn.epsR_cutoff  = 0.01;   % This is the percentage cutoff
pars_irn.adapt_epsF   = 1;
pars_irn.epsF_cutoff  = 0.05;   % This is the percentage cutoff
pars_irn.pcgtol_ini = 1e-4;
pars_irn.loops      = 5;
pars_irn.U0         = A_out-A;
pars_irn.variant       = NMP_TV_SUBSTITUTION;
pars_irn.weight_scheme = NMP_WEIGHTS_THRESHOLD;
pars_irn.pcgtol_ini    = 1e-2;
pars_irn.adaptPCGtol   = 1;

tic;
U = irntv(A_out-A, {}, 30, pars_irn);
t0=toc;

Y=U+A;
Y=im2gray(Y);
% figure;imshow(Y);

% S=ftsaliency(A);
% figure;imshow(S);%显著区域
% W=10*tan(S);
% 
% W=W(:);
% W1=1+W;
% for i=1:m*n
%     W2(i,1)=1/W1(i,1);
% end
% % W=diag(W);
% A=A(:);
% A_out=A_out(:);%转换为列向量





