function [bestT, err]=wk1lv2n4(data, labels, n)
% Implement a decision stump. It should be applied to a separable dataset
% which contains two features and one label. n indicates which feature to
% be classify. Return the stump and error rate.
%if(n>2 || n<1)
   % error('n must be 1 or 2');
%end
stepsize=1;
minErr=9999;
minX=min(data(:, n));
maxX=max(data(:, n));
for t=minX: stepsize: maxX
    numErr=0;
    for i=1:size(data)
        if(data(i,1)>=t) % predication of label = 1
            if(labels(i, 1)==0)
                numErr=numErr+1;
            end
        else % prediction of label = 0
            if(labels(i,1)==1)
                numErr=numErr+1;
            end
        end
    end % find out the numErr at the given t
    if(numErr<minErr)
        minErr=numErr;
        bestT=t;
    end
end
err=minErr/size(data, 1);
end

