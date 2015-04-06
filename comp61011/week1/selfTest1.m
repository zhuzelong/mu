% Test functions: sum of all elements, sum of elements greater than 0,
% negative matrix
A=2*rand(10)-1;
sumOfAll=wk1SelfTestSumOfAll(A);
sumOfPositive=wk1SelfTestSumOfPositive(A);
negativeM=wk1SelfTestNegativeMatrix(A);
