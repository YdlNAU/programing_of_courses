## Author: 虞达浪 <yudalang@ydl-iMac.local>
## Created: 2017-10-01
## Aim: To standard type

function [c,A,vartype,lb] = to_standard_type(s,c,A,ctype,vartype)
  if s == 1,
  	c = -c;
  	s = -1;
  endif
  
  for i = 1: length (ctype),
  	if ctype( i ) == 'U',
  		new_col = zeros ( size( A,1) ,1);
  		new_col ( i ) = 1;
  		A = [A, new_col];
  	elseif ctype ( i) == 'L',
  		new_col = zeros ( size( A,1) ,1);
  		new_col ( i ) = -1;
  		A = [A, new_col];
  	end
  endfor
  
  for i = 1: length (vartype),
  	if vartype ( i ) == 'F',
  		new_col = ones ( size( A,1) ,2);
  		new_col( :,2) = - new_col (: ,2);
  		if i == 1,
  			A = [A(:, i) .* new_col , A(:,2:size (A ,2)) ];
  		elseif i == length (vartype),
  			A = [A(:,1: i-1), A(:, i) .* new_col];
  		else
  			A = [A(:,1: i-1), A(:, i) .* new_col , A(:,(i+1):size (A ,2)) ];
  		endif	
  	endif	
  endfor
  % 变更 c 与 vartype
  if (size(A,2) > length(c)),
    new_col = zeros( size(A,2),1);
    new_col(1:length (c)) = c;
    c = new_col;
    
    vartype(1:size(A,2)) = "C";
    lb(1: size(A,2)) = 0;
    lb = lb';
   endif
  
endfunction