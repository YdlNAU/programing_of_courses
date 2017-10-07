## Author: 虞达浪 <yudalang@ydl-iMac.local>
## Created: 2017-10-01
## Statement: 单纯形法1：根据单纯型法表上作业编程，以课本 P29 例题做测验

% 要注意：1.化成标准型。可以用 to_standard_type 子程序

function [target,x] = simplex_method1(c,A,b)

% 选择初始基变量，通过遍历列向量
B = []; n_B = 0; %用来存储列向量,n_B 起指示作用
x_base = []; % 存储基变量的位置, 如基变量是 x1, x2, x3
if_m_change = 0; %记载是否改变A矩阵
for i = 1 : length(A), % length 默认显示列的个数
   count = 0;	
	 loca = 0; % 如果cound =1 记录一下这个列向量中不为0的元素所在的行
	 for j = 1 : length (A(:,i)),
	     if A(j,i) != 0,  % i is col ; j is row;
			     count = count + 1;
					 loca = j;
			 end
	end	
	if count == 1,
		n_B = n_B + 1; 
		x_base(n_B) = i;
		% check： 防止基向量构成的矩阵，出现[2,0,0]或者[0,0.3,0]这种情况
		if A(loca,i) != 1, % .* 1/A(loca,i)
			disp ( " A matrix row has changed!" );
			A(:,i) = A(:,i) .* 1/A(loca,i);
			if_m_change = 1;
		end	
		B(:,n_B) = A(:,i);
	end
	if size(B,2) >= length (A(:,1)), % 这里不能用length(B)了，因为向量的话直接回显示个数
		break;
		disp( 'm is reach')
	end
end

#{
%disp("基变量与基变量系数矩阵");
x_base
B
#}

if if_m_change,
	A
  disp("基变量系数矩阵与约束条件改变");
end


% 初始基可行解
x = zeros ( size (A,2),1 ); % 完整的解
x_jibl = zeros ( size (A,1) , 1); % 声明基变量对应解的分量

x_jibl = b - A(:,x_base) * x_jibl; % 对应于 32页的基本迭代式，得到基解
% x_base 是基变量对应于全部变量的index；x_not_base是基变量对应于全部变量的index
x(x_base) = x_jibl;
x_not_base = setdiff(1:length(x),x_base);

M_iter = [ x_jibl, A];%迭代矩阵

circle = 0;

while (1), %循环从这边开始
  circle = circle + 1
  sigma = c' - c(x_base)' * M_iter( : , 2: size(M_iter,2)) ;
  %sigma = c(x_not_base) -  A(:,x_not_base)' * c(x_base)   % 非基变量的检验数
	x(x_base) = M_iter(: ,1);
  x(x_not_base) = 0;
  %输出目标函数
  %x(x_base)
  target = c' * x;
  x;
  #{
    % disp("查看一下基变量与非基变量！")
    x_base
    x_not_base
    #}

  % judge !
  if sum (sigma(x_not_base) <= 0) == length(sigma(x_not_base)),
  	if sum ( sigma(x_not_base) == 0) >= 1,
  	disp("infinite soloves! 无穷多解\n")
  	else	
  	disp(" We get the anwser!得到最优解\n")
  	end
  	break;
  	
  end
  
  if sum (sigma(x_not_base) > 0) == 1,
  	ind = find (sigma < 0);
  	if sum ( A(:,ind) > 0 ) ==0,
  		disp("No optimal solution! 无界解！\n")
  		break;
  	endif	
  	
  end
  
  if sum ( sigma <=0) == length(sigma),
    find(c == 0);
    ind = intersect (find(c == 0),x_base);
    if x(ind) ~=0,
      disp("No solutiion!无可行解\n")
      break;    
    endif
  endif


  % P 34 确定换入变量，与换出变量
  [max_value,ind] = max( sigma );
  in_variable = ind;  % 换入变量在原来A矩阵中的位置
  
  tmp = M_iter ( : , in_variable + 1);
  tmp (tmp <= 0) = 10^(-3); % 注意这是一个
  
  thta_tmp = M_iter(: ,1) ./ tmp ;
  [thta,ind] = min(thta_tmp);
  
  out_variable = x_base (ind);
 
  
  % 基变量置入出与非基变量换出
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
  
  % 变换A 矩阵
  for i = 1: size(A,1),
  	%[i,x_base(i)] % 这些数需要变为1,同时该列其它元素需要为0
  	M_iter( i , : ) = M_iter (i , :) * 1 / M_iter ( i , x_base( i )+1 );
  	for j = setdiff (1 : size(A,1) , i ),
  		if M_iter( j,x_base( i )+1 ) != 0,
  				M_iter ( j , : ) = M_iter ( j , : ) - M_iter( j,x_base( i )+1 ) * M_iter (i , :) ;
  		endif	
  	endfor	
  end
    
endwhile

endfunction