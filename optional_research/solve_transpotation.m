## Author: 虞达浪 <yudalang@ydl-iMac.local>
## Created: 2017-10-01
## Aim: To standard type

function [xopt, fopt, errnum, extra] = solve_transpotation(production,sell,sheet)

  [c,A,b] = to_simplex_form (production,sell,sheet);
  ctype ="S";
  ctype(1:size(A,1)) = "S";
  vartype = "C";
  vartype(1:size(A,2)) = "C";
  lb = [0 0 0]';
  lb(1:size(A,2)) = 0;
  ub=[0 0 0]';
  ub(1:size(A,2)) = max(b);
  sense = 1; 
  [xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);
endfunction