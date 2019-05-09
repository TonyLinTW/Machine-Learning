clc
load('dataset4.mat');

%Gradient Descent
H=2;
E=0.005;
theta = rand(size(X,2),1);
last_theta=theta+3*E;
count=0;
total_risk=double.empty;
total_errors=double.empty;

while norm(theta-last_theta)>=E
   
    f_result = 1./(1+exp(-X*theta));
    f_result(f_result > 0.5) = 1;
    f_result(f_result <= 0.5) = 0;
    r = risk(X, Y, theta );
    total_risk=[total_risk;r];
    err = sum(f_result~=Y)/length(Y);
    total_errors=[total_errors;err];
   
    last_theta = theta ;
    G=gradient(X, Y, theta );
    theta = theta - H*G;   
    count=count+1;
    if count==180000
        break;
    end
end

figure;
plot (1: count , total_errors , 'b' , 1: count , total_risk , 'r' );
title('Error VS Risk');
legend({'Errors','Risk'},'Location','Northeast')
xlabel('iteration');
ylabel('risk & errors');
saveas(gcf,sprintf('Error VS Risk.png'));


a=0:0.01:1;
b=(-theta (3) - theta (1).* a)/ theta (2);
figure;
plot (a, b, 'g' );
title('Distribution Plot');
xlabel('x1');
ylabel('x2');
hold on ;
plot (X(: , 1 ) , X(: , 2 ) , 'x' ) ;
saveas(gcf,sprintf('Distribution Plot.png'));
