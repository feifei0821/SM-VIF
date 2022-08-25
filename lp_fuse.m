function Y = lp_fuse(M1, M2, zt, ap, mp)
%Y = fuse_lap(M1, M2, zt, ap, mp) image fusion with laplacian pyramid
%
%    M1 - input image A
%    M2 - input image B
%    zt - maximum decomposition level(���ֽ⼶��/�ںϲ���)
%    ap - coefficient selection highpass (see selc.m) ����ͨϵ��ѡ��
%    mp - coefficient selection base image (see selb.m) ����ͼϵ��ѡ��
%
%    Y  - fused image   

%    (Oliver Rockinger 16.08.99)
% whos
% check inputs 
[z1 s1] = size(M1);
[z2 s2] = size(M2);
M1=double(M1);
M2=double(M2);
if (z1 ~= z2) | (s1 ~= s2)
  error('Input images are not of same size');
end;   %�ж�����ͼ�ߴ��Ƿ�һ��

% define filter �������˲�������˹��������
w  = [1 4 6 4 1] / 16;

% cells for selected images
E = cell(1,zt);  %zt�ںϲ���
% tic
% loop over decomposition depth -> analysis  ��ѭ���ֽ����->������
for i1 = 1:zt 
    tic     %tic���浱ǰʱ�䣬toc��¼�������ʱ��
  % calculate and store actual image size �����㲢�洢ʵ��ͼ���С��
  [z s]  = size(M1); 
  zl(i1) = z; sl(i1)  = s;
  
  % check if image expansion necessary �����ͼ���Ƿ���Ҫ��չ/�ж���ż��
  if (floor(z/2) ~= z/2), ew(1) = 1; else, ew(1) = 0; end;
  if (floor(s/2) ~= s/2), ew(2) = 1; else, ew(2) = 0; end;

  % perform expansion if necessary ����Ҫʱִ����չ/������չΪż����
  if (any(ew))
  	M1 = adb(M1,ew);
  	M2 = adb(M2,ew);
  end;	

  % perform filtering ��ִ�й���/��ͨ�˲���
  G1 = conv2(conv2(es2(M1,2), w, 'valid'),w', 'valid'); %conv2��ά�����es2�Գ���չ
  G2 = conv2(conv2(es2(M2,2), w, 'valid'),w', 'valid');
 
  % decimate, undecimate and interpolate ��������δ����������ֵ/G1��G2�²������ϲ�����ͨ�˲�����������У�
  M1T = conv2(conv2(es2(undec2(dec2(G1)), 2), 2*w, 'valid'),2*w', 'valid');  %dec2�����ϲ���
  M2T = conv2(conv2(es2(undec2(dec2(G2)), 2), 2*w, 'valid'),2*w', 'valid');
%   toc76

% tic
  % select coefficients and store them ��ѡ��ϵ�����洢/��Ƶ�Ӵ�ͼ��ϵ��ѡ��
  E(i1) = {selc(M1-M1T, M2-M2T, ap)};
% toc
  % decimate 
%  tic  ���²�����
  M1 = dec2(G1);
  M2 = dec2(G2);
%   toc
% toc
% feature ('memstats')

end;
% toc
% select base coefficients of last decompostion stage ����Ƶ�Ӵ�ͼ��ϵ��ѡ��
% tic
M1 = selb(M1,M2,mp);
% figure
% imshow(uint8(M1));
% figure
% imshow(uint8(M2));
% figure
% imshow(uint8(M3));
% toc
% whos
% feature ('memstats')
% toc
% loop over decomposition depth -> synthesis  ��ͼ���ع���
% tic
for i1 = zt:-1:1
  % undecimate and interpolate 
%   tic
  M1T = conv2(conv2(es2(undec2(M1), 2), 2*w, 'valid'), 2*w', 'valid');
  % add coefficients
  M1  = M1T + E{i1};
%   toc
  % select valid image region ��ѡ��ͼ����Ч����
  M1 	= M1(1:zl(i1),1:sl(i1));
%   feature ('memstats')
% whos
end;

% feature ('memstats')
% copy image
Y = M1;
% toc
