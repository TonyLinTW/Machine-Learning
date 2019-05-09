clc
load('data3.mat');

X=data(:,1:2);
X=[X ones(size(X,1),1)];
Y=data(:,3);

theta = rand(size(X,2),1);
theta2 =theta;

count=0;
total_risk=double.empty;
total_errors=double.empty;


while 1
    
    f_result = X*theta;
    f_result2 = X*theta;
    f_result(f_result < 0) = -1;
    f_result(f_result >= 0) = 1;
    
    %r = risk(X, Y, theta );
    num=0;
    r=0;
    for i=1:size(f_result,1)
        if(f_result(i)~=Y(i))
            r=r+Y(i)*f_result2(i);
            num=num+1;
        end
    end
    if num~=0
        r=r*(-1)/num;
    end
    total_risk=[total_risk;r];
    
    err = sum(f_result~=Y);
    total_errors=[total_errors;err];
    if err==0 
        break;
    end
    count=count+1;
    if count==1000
        break;
    end
    disp(count);
  
    %gradient
    for i=1:size(f_result,1)
        if (f_result(i)~=Y(i))
            theta=theta+(Y(i).*X(i,:)).';
            %disp(i);
            %disp((Y(i).*X(i,:)).');
        end
    
    end
 
end

figure;
plot (1: count+1 , total_errors , 'b' , 1: count+1 , total_risk , 'r' );
title('Classification error VS perceptron error');
legend({'Classification error','Perceptron error'},'Location','Northeast')
xlabel('iteration');
ylabel('errors');
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