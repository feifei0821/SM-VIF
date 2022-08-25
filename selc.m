function Y = selc(M1, M2, ap)
%Y = selc(M1, M2, ap) coefficinet selection for highpass components
%高通分量系数选择
%
%    M1  - coefficients A
%    M2  - coefficients B
%    mp  - switch for selection type 切换选择类型
%          mp == 1: choose max(abs) 选择绝对值最大
%          mp == 2: salience / match measure with threshold == .75 (as proposed by Burt et al)
%          mp == 3: choose max with consistency check (as proposed by Li et
%          al)用一致性检查选择最大
%          mp == 4: simple choose max 最大值
          %mp==5:剃度最大值
          %mp==6:0
%
%    Y   - combined coefficients

%    (Oliver Rockinger 16.08.99)

% check inputs 
[z1 s1] = size(M1);
[z2 s2] = size(M2);
if (z1 ~= z2) | (s1 ~= s2)
  error('Input images are not of same size');
end;

% switch to method
switch(ap(1))
 	case 1, 
 		% choose max(abs)
%figure;imshow(uint8(M1));
%figure;imshow(uint8(M2));
 		mm = (abs(M1)) > (abs(M2));
  	Y  = (mm.*M1) + ((~mm).*M2);
%     Y  = M1 + M2;
 
 	case 2,
  	% Burts method 
  	um = 3; th = .75;
  	% compute salience 计算显著性
  	S1 = conv2(es2(M1.*M1, floor(um/2)), ones(um), 'valid'); 
  	S2 = conv2(es2(M2.*M2, floor(um/2)), ones(um), 'valid'); 
  	% compute match 
  	MA = conv2(es2(M1.*M2, floor(um/2)), ones(um), 'valid');
  	MA = 2 * MA ./ (S1 + S2 + eps);
  	% selection 
    m1 = MA > th; m2 = S1 > S2; 
    w1 = (0.5 - 0.5*(1-MA) / (1-th));
    Y  = (~m1) .* ((m2.*M1) + ((~m2).*M2));
    Y  = Y + (m1 .* ((m2.*M1.*(1-w1))+((m2).*M2.*w1) + ((~m2).*M2.*(1-w1))+((~m2).*M1.*w1)));
  	
  case 3,	       
  	% Lis method 
  	um = 3;
    % first step
  	A1 = ordfilt2(abs(es2(M1, floor(um/2))), um*um, ones(um));%二维顺序统计量滤波将n个非零数值按小到大排序后处于第k个位置的元素作为滤波器的输出
  	A2 = ordfilt2(abs(es2(M2, floor(um/2))), um*um, ones(um));
    % second step
  	mm = (conv2(double((A1 > A2)), ones(um), 'valid')) > floor(um*um/2);
  	Y  = (mm.*M1) + ((~mm).*M2);
 
  case 4, 
  	% simple choose max 
  	mm = M1 > M2;
  	Y  = (mm.*M1) + ((~mm).*M2);
  case 5,
      G1=phasecong2(M1)*255;
      G2=phasecong2(M2)*255;
      gausfilter=fspecial('gaussian',[1,1],5);
%       
%       G1=M1-guidedfilter(M1,M1,10,1);
%       G2=M2-guidedfilter(M2,M2,10,1);
%     G1=grad(A);
%     G2=grad(B);
%     G1=edge(uint8(A),'sobel',0.12);

%     figure
%     subplot(1,2,1);
%     imshow(uint8(G1*4));title('IR')
%     subplot(1,2,2);
%     imshow(uint8(G2*4));title('VIS')%相位一致性特征
    
    mm = G1 > G2;
%     mm = abs(G1) > abs(G2);
%     mm1=imfilter(mm,gausfilter);
    mm1=mm;
%     mm1=G1./(G1+G2);
    mm2=1-mm1;
    mm1=guidedfilter(M1,mm1,2,1);
    mm2=guidedfilter(M2,mm2,2,1);
%     mm2=1-mm1;
%     Y  = (mm1.*M1) + (mm2.*M2);
  	Y  = (mm1.*M1) + (mm2.*M2);
    case 6,
        Y=0;
  otherwise,
  	error('unkown option');
end;  
 



