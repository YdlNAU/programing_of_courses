## Author: 虞达浪 <yudalang@ydl-iMac.local>
## Created: 2017-10-01
## Aim: the entry function main:


% use the default glpk package for quick
clear;clc;
c = [2, 3]';
A = [ 1, 2;
      4, 0;
      0, 4];
b = [8, 16, 12]';
lb = [0, 0]';
ub = [];
ctype = "UUU";
vartype = "CC";
s = -1; % 1 is minimization; -1 is maximization
param.msglev = 1;
param.itlim = 100;
[xmax, fmax, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, s, param);

% 利用图解法

value = tu_jie_fa(A,b,c);

% 利用 to_standard_type()化标准型
% 下面这几个输出变量是
[c,A,vartype,lb] = to_standard_type(s,c,A,ctype,vartype);

[xmax, fmax, status, extra] = glpk (c, A, b, lb, ub, ctype, vartype, s, param);

%单纯型法1：

% 下面的这个例子不适合我编写的程序，因为初始在寻找初始可行解时找不出单位矩阵
c = [1 -2 0 3 -3 0 0]';

A = [ 1, 1, 0, 1, -1,1,0;
      1, -1, 0, 1, -1,0,-1;
			-3, 1, 0, 2, -2,0,0];
b = [7,2,5]';


c = [2 3 0 0 0]';

A = [ 1, 2, 1, 0, 0;
      4, 0, 0, 1, 0;
			0, 4, 0, 0, 1];
b = [8, 16, 12]';

%[target,x] = simplex_method1(c,A,b);

[target,x] = simplex_method(c,A,b);

% P135 write the function for ILP

c = [40 90 ]';
A = [9 7;
     7 20];
     
b = [56 70]';

lb = [0, 0]';
ub=[Inf Inf]';
ctype = "UU";
vartype = "II"; % C or I
sense = -1;     % 1 is minimization; -1 is maximization

%首先直接用glpk解
[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);


[xopt, fopt, errnum, extra] = ILP_fzdjf (c, A, b, lb, ub, ctype, vartype, sense);



