clear all;
close all;

load('teapots.mat');

pic=20;

f=figure;
imagesc(reshape(teapotImages(pic,:),38,50));
colormap gray;
print(f, '-depsc' , 'org.eps') ;

%mean
mean_matrix = mean(teapotImages,1);
x = bsxfun(@minus, teapotImages, mean_matrix);

% covariance
cvr = cov(x);

% eigenvector
[V,D] = eig(cvr);
V = fliplr(V);

% show mean and top 3 eigenvectors
f=figure;
imagesc(reshape(mean_matrix, 38, 50));
colormap gray;
print(f, '-depsc' , 'mean.eps') ;

for i = 1:3
    figure;
    imagesc(reshape(V(:,i),38,50));
    colormap gray;
end


%reconstruct
for pic=10:10:100
    f=figure;
    imagesc(reshape(teapotImages(pic,:),38,50));
    colormap gray;
    saveas(f,sprintf('Org%d.png',pic));
    
    newV = V(1:1900, 1:3);
    y=teapotImages(pic,:)-mean_matrix;
    y=y';
    model = pinv(newV)*y;
    result=mean_matrix'+newV*model;

    f=figure;
    imagesc(reshape(result(:,1),38,50));
    colormap gray;
    saveas(f,sprintf('recons%d.png',pic));
end

