function result=doubleSum(x, y)
result=0;
for i=1:10
    for j=1:10
        result=result+i*x^2+j*y^3;
    end
end
end