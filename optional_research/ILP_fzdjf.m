## Author: 虞达浪 <yudalang@ydl-iMac.local>
## Created: 2017-10-12
## Statement: 课本 P135 页分支定界法;

% 要注意：调用的线性规划解释用自带的函数

function [retval] = ILP_fzdjf (c, A, b, lb, ub, ctype, vartype, sense)
  % if no optimal solution than break
  [xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);
  if errnum ~= 0,
    disp("errnum not equal to 0!");
    break;
  endif
  
  % Main
  for i = 1 : length(vartype),
    vartype ( i ) = 'C';
  endfor
  % tempoary
  new_lb = lb;
  new_ub = ub;
  % new bounds
  new_lbs = lb;
  new_ubs = ub;
  
  # 
  for i = 1:length (xopt),

    if rem ( xopt(i) , 1) ~= 0, % not integer
    
      new_ub ( i ) = floor ( xopt(i) ) ;
      new_ubs( :,i) = new_ub;
      new_lbs( :,i) = lb;
      %[new_xopt, new_fopt, errnum, extra] = glpk (c, A, b, lb, new_ub, ctype, vartype, sense);
      
      new_lb ( i ) = floor ( xopt(i) ) + 1;
      
      %[new_xopt, new_fopt, errnum, extra] = glpk (c, A, b, new_lb, ub, ctype, vartype, sense);
      
    endif
  endfor
  #
  
  for i = 1:length (xopt),
    if rem ( xopt(i) , 1) ~= 0, % not integer
      
      
    endif
  endfor
  
  for i = 1:length (xopt),
  
  
  endfor
  
endfunction

function [retval] = sub_calculate (c, A, b, lb, ub, ctype, vartype, sense),
  
  [xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);
  
  % judge the every element in x to determete the 
  
  for i = 1:length (xopt),
    if rem ( xopt(i) , 1) ~= 0, % not integer
      break;
      % we need to use i 
    endif
  endfor
  
  % create new bound and calculate the value
  new_lb = lb;
  new_ub = ub;
  
  % for record the left and right branch states
  left = 0; % 0 means x are not integer nor does errnum equal to 0
  right = 0;
  
  % new bound of i
  %floor ( xopt(i) )
  %floor ( xopt(i) ) + 1
  % old bound of i
  %lb( i )
  %ub( i)
  if floor ( xopt(i) ) < lb ( i),
    disp( " floor ( xopt(i) ) < lb ( i) \n"); 
  else
    new_ub (i) = floor ( xopt(i) );
    [xopt, fopt, errnum, extra] = glpk (c, A, b, lb, new_ub, ctype, vartype, sense);
    [xopt',fopt]
    if (sum ( rem ( xopt , 1 ) == 0 ) == 0) && (errnum ~= 0) ,
      left = 1;
    endif
  endif
  
  if floor ( xopt(i) ) + 1 > ub ( i),
    disp( " floor ( xopt(i) ) + 1 > ub ( i) \n");  
  else
    new_lb (i) = floor ( xopt(i) ) + 1;
    [xopt, fopt, errnum, extra] = glpk (c, A, b, new_lb, ub, ctype, vartype, sense);
    [xopt',fopt]
    if (sum ( rem ( xopt , 1 ) == 0 ) == 0) && (errnum ~= 0) ,
      right = 1;
    endif
  endif

  % return
  if (left == 1) && (right == 1),
    return;
  else
    [retval] = sub_calculate (c, A, b, lb, new_ub, ctype, vartype, sense) ;
    [retval] = sub_calculate (c, A, b, new_lb, ub, ctype, vartype, sense) ;
  endif
  
endfunction
