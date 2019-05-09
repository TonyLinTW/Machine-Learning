function result=risk(x,y,theta)
    tmp_r=(y-1).*log(1-1./(1+exp(-x*theta)))-y.*log(1./(1+exp(-x*theta)));
    tmp_r(isnan(tmp_r))=0;
    result=mean(tmp_r);
end