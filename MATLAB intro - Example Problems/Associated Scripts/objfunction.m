function s = objfunction(a,x,y)
% Objective function is a sum-of-squares difference between the fitting
% function and the data
% fminsearch() will minimize the objective function, giving a least-squares
% fit
% inputs:
%   a: 1x2 vector, x: 1xN vector, y: 1xN vector
s = sum((y-fitfunction(a,x)).^2);