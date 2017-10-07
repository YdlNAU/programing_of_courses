## Author: 虞达浪 <yudalang@ydl-iMac.local>
## Created: 2017-10-03
## Statement: 处理运输问题,转变格式
 
%for test
%production = [5 6 2 9]';
%sell = [4 4 6 2 4]';
%sheet = [10 20 5 9 10; 2 10 8 30 6; 1 20 7 10 4; 8 6 3 7 5];


function [c,A,b] = to_simplex_form (production,sell,sheet)
  #输出的x的排列是 x11 x12 x13 x14
  c = sheet(1,:);
  for i = 2:size(sheet,1),
    c = [c,sheet(i,:)];
  endfor
  c=c';

  b = [production;sell];
  
  m = size(sheet,1);
  n = size(sheet,2);
  A = zeros(m + n, m*n);
  
  for i = 1:m,
    
    A(i,((i-1)*n+1):(i*n)) = ones(1,n);
  endfor
  for i = 1:n,
    for j = i:n:m*n,
      A(i + m,j) = 1;
    endfor  
  endfor
  
  
endfunction
