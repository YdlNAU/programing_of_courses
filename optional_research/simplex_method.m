## Author: 虞达浪 <yudalang@ydl-iMac.local>
## Created: 2017-10-01
## Statement: 单纯形法2：课本 P59 页矩阵表达;

% 要注意：1.化成标准型。可以用 to_standard_type 子程序

function [z,x] = simplex_method(c,A,b)
% 选择初始基变量，通过遍历列向量
%注意：在不引入人工变量M的情况下，需要人工进行初等行变换得到初始解
B = []; n_B = 0; %用来存储列向量,n_B 起指示作用
record_row = 0; %记录进击变量的行号
x_base = []; % 存储基变量的位置, 如基变量是 x1, x2, x3
if_m_change = 0; %记载是否改变A矩阵
for i = size(A,2):-1:1, % 循环列，倒着来更好
   count = 0;	
	 loca = 0; % 如果cound =1 记录一下这个列向量中不为0的元素所在的行
	 for j = 1 : length (A(:,i)),
	     if A(j,i) != 0,  % i is col ; j is row;
			     count = count + 1;
					 loca = j;
			 end
	end	
	if count == 1,
  % 不能一直变换同一行
    if ismember(loca,record_row),
      continue;
    endif
    
		n_B = n_B + 1; 
    record_row(n_B) = loca;
		x_base(n_B) = i;
		% check： 防止基向量构成的矩阵，出现[2,0,0]或者[0,0.3,0]这种情况
		if A(loca,i) != 1, % .* 1/A(loca,i)
			disp ( " A matrix row has changed!" );
      tmp = 1/A(loca,i);
			A(loca,:) = A(loca,:) * tmp;
      b(loca) = b(loca) * tmp;

			if_m_change = 1;
		end	
		B(:,n_B) = A(:,i);
	end
	if size(B,2) >= size(A,1), % 这里不能用length(B)了，因为向量的话直接回显示个数
		break;
		disp( 'm is reach')
	end
end

if if_m_change,
	A
  b
end

x_base
% 初始基可行解
x = zeros ( size (A,2),1 ); % 完整的解
x_not_base = setdiff(1:length(x),x_base);

N = A(: , x_not_base );
x_N = x( x_not_base);
B_inv = inv (B);
x_B = B_inv * b - B_inv * N * x_N; % because x_N is 0, so
x(x_base) = x_B; x(x_not_base) = x_N;
c_B = c( x_base)';c_N = c( x_not_base)';
z = c_B * B_inv * b;
sigma_N = c_N - c_B * B_inv * N
sigma = c' - c_B* B_inv *A
c
c_B* B_inv *A


circle = 0;
while 1,
	
	circle = circle + 1
	
	[max_value,ind] = max( sigma_N );
	in_variable = x_not_base (ind) ; % 换入变量在原来A矩阵中的位置
	
	denominator = B_inv * A( :,in_variable);
	denominator ( denominator <= 0) = 10 ^ (-4); % 因为分母要大于0，所以给一个很小的数
	[thta,ind] = min( B_inv * b ./ denominator);
	out_variable = x_base (ind); % ind 变量有用, (ind , in_variable ) 是主元素
	
	% 基变量换出与非基变量换出
	for i = 1: length(x_base),
		if x_base( i) == out_variable,
			x_base ( i) = in_variable;
		end	
	end
	
	for i = 1: length(x_not_base),
		if x_not_base( i) == in_variable,
			x_not_base ( i) = out_variable;
		end	
	end
	N = A ( : , x_not_base);
	
	p = B_inv * A( :, in_variable) ;%系数向量p
	ese = - p / p (ind); % may be 0;
	ese ( ind ) = 1 / p (ind);
	E1 = eye ( length ( B ) );
	E1(:, ind ) = ese; %换出变量的列替换
	
	B_inv = E1 * B_inv ;
	
	% judge the sigma for the ending
  
  #{
  if sum ( sigma <=0) == length(sigma),
    % find( c==0) 是松弛变量
    ind = intersect (find(c == 0),x_base);

    if sigma(ind) ~=0,
      disp("No solutiion!无可行解\n")
      break;    
    endif
  endif
  #}
  
	if sum (sigma_N <= 0) == length(sigma_N),
		if sum ( sigma_N == 0) >= 1,
		disp("infinite soloves! 无穷多解\n")
		else	
		disp(" We get the anwser!得到最优解\n")
    break;
		end
	end
	
	if sum (sigma_N > 0) == 1,
		ind = find (sigma_N < 0);
		if sum ( A(:, x_not_base(ind)) > 0 ) ==0,
			disp("No optimal solution! 无界解！\n")
			break;
		endif	
		
	end
  % 不能陷入死循环
  if circle > 30,
    disp("Can't loop out\n");
    break;
  endif
	
	c_B = c( x_base)';c_N = c( x_not_base)';
	z = c_B * B_inv * b; % b won't change !
	sigma_N = c_N - c_B * B_inv * N
  sigma = c' - c_B* B_inv *A

  
  
  % get the target and x
  z = c_B * B_inv * b
  x_B = B_inv * b;
  x = zeros ( size (A,2),1 );
  x(x_base) = x_B
  
	

	
	% 下面是新一轮的
	N = B_inv * N;
	B = inv (B_inv );
	
end

endfunction