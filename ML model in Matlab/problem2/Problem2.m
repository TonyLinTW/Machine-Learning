clc

load('problem2.mat','x');
load('problem2.mat','y');

idx = randperm(400);
x_training = x(idx(1: 200), :);
y_training = y(idx(1: 200), :);
x_test=x(idx(201: 400), :);
y_test=y(idx(201: 400), :);

total_l=2000

err_matrix=double.empty;
errT_matrix=double.empty;
for l=1:1:total_l
    [err,model,errT] = polyreg2(x_training,y_training,l,x_test,y_test);
    err_matrix=[err_matrix;err];
    errT_matrix=[errT_matrix;errT];
end

[m,m_l]=min(errT_matrix)

clf
j=1:1:total_l;
plot(j,err_matrix,'r');
hold on
plot(j,errT_matrix,'g');
plot(m_l,m,'X')
title('Loss Compare');
xlabel('Lambda');
ylabel('Error');
legend({'training loss','test loss'},'Location','Northeast')
saveas(gcf,sprintf('loss_compare.png'));

