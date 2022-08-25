I1=imread('1.png');
I2=imread('2.png');

If=enhance_fuse(I1,I2);

figure
imshow([I1 I2 If]);