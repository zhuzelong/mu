function rslt=wk1SelfTestSumOfPositive(m)
% accepts a N*N matrix, return the sum of all elements greater than 0
A=1/2*(m+abs(m));
rslt=sum(sum(A));
end

