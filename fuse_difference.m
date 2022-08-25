% A=double(imread('B_IR.jpg'));
% B=double(imread('B_VIS.jpg'));
function Y=fuse_difference(A,B)

% F1=GTF_fuse(B,A);
% F2=lp_fuse(A,B,4,5,3);
F3=gu_fuse(A,B,1);

Y=F3;

% figure;imshow(uint8(F1));
% figure;imshow(uint8(F2));
% figure;imshow(uint8(F3));

