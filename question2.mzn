% Mazigh Ouanes - 1721035
% Vithor Bertalan - 2135362

include "globals.mzn"; 

int: n = 5;
% the given results
array[1..4] of int: res = [1,2,5,7];

% number of points for each player
array[1..n] of var 0..3*n: x;

% (i, j) is the result of player i against player j
array[1..n, 1..n] of var {0,1,3}: matches;

% sets the given results
constraint forall (i in 1..4) (x[i] = res[i]);
% zeroes the main diagonal
constraint forall (i in 1..n) (matches[i,i] = 0);
% sums the rows so that they represent the total score
constraint forall (i in 1..n) (sum(j in 1..n) (matches[i,j]) == x[i]);
% sets the distribution of points
constraint forall(i, j in 1..n)(
  if i != j
    then if matches[i, j] = 1
      then matches[j, i] = 1
    elseif matches[i, j] = 0
      then matches[j, i] = 3
    else matches[j, i] = 0
    endif
  else matches[i, i] = 0
  endif);

output 
[
  "Scores\n"
]
++
[
  show(x)
]
++	
[
  "\nMatches\n"
]
++
[ show(matches[i,j]) ++ 
         if j == n then "\n" else " " endif |
         i in 1..n, j in 1..n
]
;