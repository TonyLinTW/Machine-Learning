clc

load('problem1.mat','x');
load('problem1.mat','y');

idx = randperm(500);
x_training = x(idx(1: 250), :);
y_training = y(idx(1: 250), :);
x_test=x(idx(251: 500), :);
y_test=y(idx(251: 500), :);

records=fopen('Problem1_records.txt','w');

err_matrix=double.empty;
errT_matrix=double.empty;
for i = 1:1:40
   
   disp(i)
   [err,model,errT] = polyreg(x_training,y_training,i,x_test,y_test);
   err_matrix=[err_matrix;err];
   errT_matrix=[errT_matrix;errT];
   
   if i<=9 
   hold on
   title(sprintf('d=%d',i));
   saveas(gcf,sprintf('figure_%d.png',i));
   
   fprintf(records,'d=%d\n',i);
   fprintf(records,'%s: ','Traing_error');
   fprintf(records,'%f\n',err);
   fprintf(records,'%s: ','Test_error');
   fprintf(records,'%f\n',errT);
   fprintf(records,'%s:\n','Theta');
   fprintf(records,'%f\n',model);
   fprintf(records,'\n');
   end
   
end
fclose(records);

clf
j=1:1:40
plot(j',err_matrix,'r');
hold on
plot(j',errT_matrix,'g');
title('Loss Compare');
xlabel('d');
ylabel('loss');
legend({'training loss','test loss'},'Location','Northeast')
saveas(gcf,sprintf('loss_compare.png'));


