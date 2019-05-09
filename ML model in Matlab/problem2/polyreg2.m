function [err,model,errT] = polyreg2(x,y,l,xT,yT)
%
% Finds a D-1 order polynomial fit to the data
%
%    function [err,model,errT] = polyreg(x,y,D,xT,yT)
%
% x = vector of input scalars for training
% y = vector of output scalars for training
% D = the order plus one of the polynomial being fit
% xT = vector of input scalars for testing
% yT = vector of output scalars for testing
% err = average squared loss on training
% model = vector of polynomial parameter coefficients "theata"
% errT = average squared loss on testing
%
% Example Usage:
%
% x = 3*(rand(50,1)-0.5);
% y = x.*x.*x-x+rand(size(x));
% [err,model] = polyreg(x,y,4);
%

% calculate training function
I=eye(length(x(1,:)));
model = inv(x'*x+l*I)*x'*y;
err   = (1/(2*length(y)))*sum((y-x*model).^2);

%err   = (1/(2*length(y)))*sum((y-x*model).^2) + (l/(2*length(y)))*sum(model.^2);

%calculate test function
if (nargin==5)
  errT   = (1/(2*length(yT)))*sum((yT-xT*model).^2);
    %  errT   = (1/(2*length(yT)))*sum((yT-xT*model).^2) + (l/(2*length(yT)))*sum(model.^2);
end

%{
q  = (min(x):(max(x)/300):max(x))';
qq = zeros(length(q),D);
for i=1:D
  qq(:,i) = q.^(D-i);
end

clf
plot(x,y,'X');
hold on
if (nargin==5)
    plot(xT,yT,'cO');
end
plot(q,qq*model,'r')
%}
