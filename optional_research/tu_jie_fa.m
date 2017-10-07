## Author: 虞达浪 <yudalang@ydl-iMac.local>
## Created: 2017-10-01
## Aim: Write the 图解法

% first get the x 解集

function value = tu_jie_fa(A,b,c)
  for i=1:(rows(A)-(columns(A)-1)),
  
  	sub_A = A(i:(i+columns(A)-1),:);    
    sub_b = b(i:(i+columns(A)-1),:);
  	x_candi = inv (sub_A) * sub_b;
  	% veritify the s.t.
    % warning the symbol <= need to change in your real problem !!!!!!!!
  	if sum (A * x_candi <= b) == length(b),
  		xs(:,i) =  x_candi; 
  	end
    
  end;
  
  value = max( c' * xs);

endfunction

