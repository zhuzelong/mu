function result=wk1lv1n1(n)
% a loop to sum the even number from 1 to 100
result=0;
for i=1:100
    if(mod(i,2)==0)
        result=result+i;
    end
end
end

