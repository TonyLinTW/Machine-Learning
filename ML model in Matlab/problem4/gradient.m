function result = gradient (x, y, theta )

f1 = 1./(1+exp(-x* theta ));
d1 = x.* exp(-x* theta ) ;
g1 = (1-y ).* ( x - d1 .* f1 ) - y .* d1 .* f1 ;
g2=sum(g1);
g2=g2/length(y);
result=g2';

end