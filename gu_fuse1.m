function y = gu_fuse( A,B,level )
%GU_FUSE 此处显示有关此函数的摘要
%   此处显示详细说明

gausfilter=fspecial('gaussian',[11,11],5000);
B_A(:,:,1)=A;
B_B(:,:,1)=B;

for i=1:level
    B_A(:,:,i+1)=imfilter(B_A(:,:,i),gausfilter);
%     
    D_A(:,:,i)=B_A(:,:,i)-B_A(:,:,i+1);
%     figure;imshow(uint8(D_A(:,:,i)*4));
%     figure;imshow(uint8(B_A(:,:,i+1)));

    
    B_B(:,:,i+1)=imfilter(B_B(:,:,i),gausfilter);
%     
    D_B(:,:,i)=B_B(:,:,i)-B_B(:,:,i+1);
%     figure;imshow(uint8(D_B(:,:,i)*4));
%     figure;imshow(uint8(B_B(:,:,i+1)));
    
    D_F(:,:,i)=selc(D_A(:,:,i),D_B(:,:,i),5);
    figure;imshow(uint8(D_F(:,:,i))*10);
%     imwrite(uint8(D_F(:,:,i)),'fusedetail1.jpg');
    
end

% B_F=(B_A(:,:,level+1)+B_B(:,:,level+1))/2;
B_F=selb(B_A(:,:,level+1),B_B(:,:,level+1),4);
% imwrite(uint8(B_F),'fusebase1.jpg')
% B_F=B_A(:,:,level+1);
figure;imshow(uint8(B_F));

for i=1:level
    F=D_F(:,:,i);
end
% figure;imshow(uint8(F));

y=F+B_F;


end


