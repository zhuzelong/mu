function rslt=wk1SelfTestNegativeMatrix(m)
% accepts a N*N matrix, change all elements greater than 0 to 0, return the
% new matrix
rslt=1/2*(m-abs(m));
end

