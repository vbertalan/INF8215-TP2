% Mazigh Ouanes - 1721035
% Vithor Bertalan - 2135362

include "globals.mzn"; 

int: r; % number of rows 
int: c; % number of columns
array[1..r] of int: rowinsects; % total of insects by row
array[1..c] of int: colinsects; % total of insects by col
array[1..r, 1..c] of 0..r*c: knownpositions;  % known number of insects, 0 appears when unknown

array[1..r, 1..c] of var 1..r*c: x; % the final garden grid (decision variable)

% each row must sum its index in rowinsects
constraint forall (m in 1..r) (sum(x[m,..]) = rowinsects[m]);
% each column must sum its index in colinsects  
constraint forall (n in 1..c) (sum(x[..,n]) = colinsects[n]);
% if there is a value in knownpositions, copy it to x
constraint forall (m in 1..r, n in 1..c) (if knownpositions[m,n] != 0 then x[m,n] = knownpositions[m,n] endif);

output [
  "["
]
++
[
  if j = 1 then "\n" else "," endif ++
    if fix(x[i,j]) < 10 then "  " else " "  endif ++
    show(x[i,j]) ++
  if j = c then 
    ", f(" ++ show(rowinsects[i]) ++ "),"
  else 
    ""
  endif
  | i in 1..r, j in 1..c
] 
++
["\n"]++
[
  "f(" ++ show(colinsects[j]) ++ "),"
  | j in 1..c
]

++ ["]\n"]
;