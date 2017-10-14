%% solve the homeworks
clear;clc;
% p55 2.1 1-4 
c = [2 2]';
A = [1 -1;
     -0.5 1];
     
b = [-1 2]';

lb = [0, 0]';
ub=[];
ctype = "LU";
vartype = "CC";
sense = -1;     % 1 is minimization; -1 is maximization

%首先直接用glpk解
[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);

% use my own functions;
[c,A,vartype,lb] = to_standard_type(sense,c,A,ctype,vartype);
[target,x] = simplex_method(c,A,b)
break
% 再调用glpk验证
sense = -1;
ctype = "SS"
[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);


% p55 2.2 1
c = [3 -4 2 -5 5 0 0]';

A = [4 -1 2 -1 1 0 0;
     1 1 3  -1 1 1 0;
    -2 3 -1 2 -2 0 -1;];
    
b = [-2 14 2]';
    
    
A = [4 -1 2 -1 1 0 0;
     -3 2 1 0  0 1 0;
     6  1 3 0  0 0 -1;];
     
     
b = [-2 16 -2]';

lb = [0 0 0 0 0 0 0]';
ub=[];
ctype = "SSS";
vartype = "CCCCCCC";
sense = -1; 
[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);
[target,x] = simplex_method(c,A,b)
%按照课本:

c = [-3 4 -2 5]';
A = [4 -1 2 -1;
     1 1 3 -1;
     -2 3 -1 2];
     
b = [-2 14 2]';

ctype = "SUL";
vartype = "CCCC";
lb = [0 0 0 -Inf]';
ub=[];

sense = 1; 
[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);

% p55 2.3
%%(1)
c = [2 3 4 7]';
A = [2 3 -1 -4;
     1 -2 6 -7];
     
b = [8  -3]';
% 人工转化，使其产生初始可行解
A = [0 7 13 10;
     1 0 6+26/7 -7+20/7];
     
b = [14  1]';
[target,x] = simplex_method(c,A,b) %成功
%% (2)
c = [5 -2 3 -6]';
A = [1 2 3 4;
     2 1 1 2];
     
b = [7 3]';
ctype = "SS";
vartype = "CCCC";
lb = [0 0 0 0]';
ub=[];

sense = -1; 

[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);


% p56 2.6
%%(1) 
c = [2 3 -5]';
A = [1 1 1;
     2 -5 1];
b = [7 10]';
ctype = "SL";
sense = -1;
vartype = "CCC";
lb = [0 0 0]';
ub=[];

[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);
% use my own functions;
[c,A,vartype,lb] = to_standard_type(sense,c,A,ctype,vartype);
A = [ 1 1 1 0;
      1 -6 0 -1];
b = [7 3]';
[target,x] = simplex_method(c,A,b)

%% （2）

c = [2 3 1]';
A = [1 4 2;
     3 2 0];
     
b = [8 6]';
ctype = "LL";
vartype = "CCC";
lb = [0 0 0]';
ub=[];

sense = 1; 
[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);

[c,A,vartype,lb] = to_standard_type(sense,c,A,ctype,vartype);
% make sure
ctype = "SS";
sense = -1; 
[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);
[target,x] = simplex_method(c,A,b)


% p87 3.1 1-2 
% （1）
c = [6 -2 3]';
A = [2 -1 2;
     1 0 4];
     
b = [2 4]';
ctype = "UU";
vartype = "CCC";
lb = [0 0 0]';
ub=[];

sense = -1; 
[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);
[c,A,vartype,lb] = to_standard_type(sense,c,A,ctype,vartype);
[target,x] = simplex_method(c,A,b)

%（2）
c = [2 1]';
A = [3 1;
     4 3;
     1 2];
     
b = [3 6 3]';
ctype = "SLU";
vartype = "CC";
lb = [0 0]';
ub=[];

sense = 1; 

[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);
[c,A,vartype,lb] = to_standard_type(sense,c,A,ctype,vartype);
% 增广矩阵[A b] 需要变换
A=[3 1 0 0;-5 0 -1 0;-5 0 0 1;];b=[3 -3 -3]';
[target,x] = simplex_method(c,A,b)

% p88 3.3 1-2

% （1）
c = [2 2 4]';
A = [2 3 5;
     3 1 7;
     1 4 6];
     
b = [2 3 5]';
ctype = "LUU";
vartype = "CCC";
lb = [0 0 0]';
ub=[];

sense = 1; 
[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);
[c,A,vartype,lb] = to_standard_type(sense,c,A,ctype,vartype);
[target,x] = simplex_method(c,A,b)

%（2）
c = [1 2 3 4]';
A = [-1 1 -1 -3;
     6 7 3 -5;
     12 -9 -9 9];
     
b = [5 8 20]';
ctype = "SLU";
vartype = "CCCC";
lb = [0 0 -Inf -Inf]';
ub=[Inf Inf 0 Inf]';

sense = -1; 

[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);
% use my own function
c = [1 2 -3 4 -4 0 0]'
A=[-1 1 1 -3 3 0 0;6 7 -3 -5 5 -1 0;12 -9 9 9 -9 0 1];
A(2,:) = A(2,:) + 6 *A(1,:);
A(3,:) = A(3,:) + 12 *A(1,:);
b(2) = b(2) + 6 * b(1); b(3) = b(3) + 12 * b(1);
[target,x] = simplex_method(c,A,b)

%p90:3.9-(1)
c = [1 1]';
A = [2 1;1 7;]; b = [4 7]';
ctype = "LL";
vartype = "CC";
lb = [0 0]';
ub=[]';

sense = 1; 

[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);

%p90:3.9-(2)
c = [3 2 1 4]';
A = [2 4 5 1;3 -1 7 -2;5 2 1 6;]; b = [0 2 15]';
ctype = "LLL";
vartype = "CCCC";
lb = [0 0 0 0]';
ub=[]';

sense = 1; 

[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);
% 增广矩阵[A b] 需要变换
[c,A,vartype,lb] = to_standard_type(sense,c,A,ctype,vartype);
[target,x] = simplex_method(c,A,b)

% p90 3.10  

c = [-5 5 13]';
A = [-1 1 3;12 4 10;];
b = [20 90]';

ctype = "UU";
vartype = "CCC";
lb = [0 0 0]';
ub=[]';

sense = -1; 

[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);
% change !!
c = [-5 5 13]';
A = [-1 1 3;12 4 10;];
b = [20 90]';

ctype = "UU";
vartype = "CCC";
lb = [0 0 0]';
ub=[]';

sense = -1; 

[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);

% p113-114 4.3 

production = [5 6 2 9]';
sell = [4 4 6 2 4 2]';
sheet = [10 20 5 9 10 0; 2 10 8 30 6 0; 1 20 7 10 4 0; 8 6 3 7 5 0];

[c,A,b] = to_simplex_form (production,sell,sheet);
ctype ="S";
ctype(1:size(A,1)) = "S";
vartype = "C";
vartype(1:size(A,2)) = "I";
lb = [0 0 0]';
lb(1:size(A,2)) = 0;
ub=[0 0 0]';
ub(1:size(A,2)) = 9;
sense = 1; 
[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);

% test P94 
production = [7 4 9]';
sell = [3 6 5 6]';
sheet = [3 11 3 10;1 9 2 8;7 4 10 5];

[c,A,b] = to_simplex_form (production,sell,sheet);
ctype ="S";
ctype(1:size(A,1)) = "S";
vartype = "C";
vartype(1:size(A,2)) = "C";
lb = [0 0 0]';
lb(1:size(A,2)) = 0;
ub=[0 0 0]';
ub(1:size(A,2)) = 10;
sense = 1; 
[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);

% test p 114

production = [15 25 5]';
sell = [5 15 15 10]';
sheet = [10 1 20 11;12 7 9 20;2 14 16 18;];

[c,A,b] = to_simplex_form (production,sell,sheet);
ctype ="S";
ctype(1:size(A,1)) = "S";
vartype = "C";
vartype(1:size(A,2)) = "I";
lb = [0 0 0]';
lb(1:size(A,2)) = 0;
ub=[0 0 0]';
ub(1:size(A,2)) = 25;
sense = 1; 
[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);

% p113-114 4.3 (2)

production = [100 120 140 80 60]';
sell = [100 120 100 60 80 40]';
sheet = [10 18 29 13 22 0;13 10^9 21 14 16 0;0 6 11 3 10^9 0;9 11 23 18 19 0;24 28 36 30 34 0;];

[c,A,b] = to_simplex_form (production,sell,sheet);
ctype ="S";
ctype(1:size(A,1)) = "S";
vartype = "C";
vartype(1:size(A,2)) = "C";
lb = [0 0 0]';
lb(1:size(A,2)) = 0;
ub=[0 0 0]';
ub(1:size(A,2)) = 120;
sense = 1; 
[xopt, fopt, errnum, extra] = glpk (c, A, b, lb, ub, ctype, vartype, sense);


% p113-114 4.4
production = [15 25 5]';
sell = [5 15 15 10]';
sheet = [10 1 20 11;12 7 9 20;2 14 16 18];

[xopt, fopt, errnum, extra] = solve_transpotation(production,sell,sheet);
initial_xopt = xopt;
% (1)
for j = 0:10,
  sheet(2,2) =j;
  [xopt, fopt, errnum, extra] = solve_transpotation(production,sell,sheet);
  if sum(xopt == initial_xopt) == length (xopt),
    j
  endif
endfor

% (2)

for j = 12:0.3:20,
  sheet(2,4) =j;
  [xopt, fopt, errnum, extra] = solve_transpotation(production,sell,sheet);
  if sum(xopt == initial_xopt) == length (xopt),
    j
  endif
endfor

