%fminsearch() script
%Minimize the sum-of-squares difference between the data and our fitting
%function to deliver a least-squares fit of the data

%read the data file
load test_data.mat
x = test_data(:,1);
y = test_data(:,2);

%set up the plot parameters
pts = 1000;
dx = (max(x)-min(x))/pts;
xplot = min(x):dx:max(x);

%preallocate vector 'a' (for a1, a2)
a = [1 1];

%Let's compare the initial function guess with the result from fminsearch()

%Initial guess (w/o fminsearch)
yinit = fitfunction(a,xplot);
plot(x,y,'b', xplot,yinit,'ro')
xlabel('x'), ylabel('y'), title('Data and Initial Guess')

%Use fminsearch() with an 'anonymized' function
%   the anonymized function, @(f), allows fminsearch to find the parameters
%   that result in the minimized sum-of-squares difference
a = fminsearch(@(a)objfunction(a,x,y),a);

%Use optimized 'a' to find optimized y (best fit)
yfinal = fitfunction(a,xplot);

figure
plot(x,y,'b', xplot,yfinal,'go')
xlabel('x'), ylabel('y'), title('Data and Optimized Fit')