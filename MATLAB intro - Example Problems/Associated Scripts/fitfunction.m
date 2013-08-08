function f = fitfunction(a,x)
%We want to fit our data to an exponenetial with multiple variables
%inputs:
%   a: 1x2 vector, x: 1xN vector
f = a(1)*exp(a(2)*x);