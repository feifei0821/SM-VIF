function Y = es2(X, n)
%Y = ES2(X, n) symmetric extension of a matrix on all borders 所有边界上矩阵对称扩展
%    
%    X  - input matrix
%    n  - number of rows/columns to extend 要扩展的行/列数
%
%    Y  - extended matrix

%    (Oliver Rockinger 16.08.99)

[z s] = size(X);
Y                        = zeros(z+2*n, s+2*n);
Y(n+1:n+z,n:-1:1)        = X(:,2:1:n+1); 
Y(n+1:n+z,n+1:1:n+s)     = X;
Y(n+1:n+z,n+s+1:1:s+2*n) = X(:,s-1:-1:s-n);
Y(n:-1:1,n+1:s+n)        = X(2:1:n+1,:); 
Y(n+z+1:1:z+2*n,n+1:s+n) = X(z-1:-1:z-n,:); 
 



