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