classdef mylogreg < handle
    properties
        w; % weight column vector, w(numFeature+1) is intercept
        epoch;
        alpha; % learning rate or stepsize
        err; % error rate
        hypo; % value of f(x) at each data point
        plabels; % prediction of labels
        DELTA; % a matrix storing delta w in each iteration
    end % properties
    
    methods
        function obj = mylogreg(alpha)
        % constructor, user can define alpha and epoch
            if nargin == 0
                obj.alpha = 0.1;
                obj.epoch = -1;
            else
                obj.alpha = alpha;
            end % if
        end % function mylogreg

        function obj = mtrain(obj, data, labels, m) 
        % train on train dataset and build a model with momentum
        % fixed epoch
            numFeature = size(data, 2);
            numRow = size(data, 1);
            obj.epoch = numFeature * 10;

            obj.w = rand(numFeature + 1, 1); % w is a column vector, w(j+1) is intercept
            obj.DELTA = zeros(numRow + 1, numFeature + 1);
            obj.hypo = zeros(numRow, 1);

            for iter = 1:obj.epoch
                for i = 1:numRow
                    z = [data(i, :), -1] * obj.w;
                    obj.hypo(i) = 1 / (1 + exp(-z)); % hypo is f(X)
                    obj.DELTA(i + 1, 1:numFeature) = - obj.alpha * (obj.hypo(i) - labels(i)) * data(i, :) + m * obj.DELTA(i, 1:numFeature);
                    obj.DELTA(i + 1, numFeature + 1) = obj.alpha * (obj.hypo(i) - labels(i)) + m * obj.DELTA(i, numFeature + 1);
                    obj.w = obj.w + obj.DELTA(i + 1, :)';
                end % i loop
            end % iter loop
        end % function

        
        function obj = train(obj, data, labels)
            numFeature = size(data, 2);
            numRow = size(data, 1);
            obj.epoch = numFeature * 10;

            obj.w = rand(numFeature + 1, 1); % w is a column vector, w(j+1) is intercept
            obj.DELTA = zeros(numRow + 1, numFeature + 1);
            obj.hypo = zeros(numRow, 1);

            for iter = 1:obj.epoch
                for i = 1:numRow
                    z = [data(i, :), -1] * obj.w;
                    obj.hypo(i) = 1 / (1 + exp(-z)); % hypo is f(X)
                    obj.DELTA(i + 1, 1:numFeature) = - obj.alpha * (obj.hypo(i) - labels(i)) * data(i, :);
                    obj.DELTA(i + 1, numFeature + 1) = obj.alpha * (obj.hypo(i) - labels(i)); 
                    obj.w = obj.w + obj.DELTA(i + 1, :)';
                end % i loop
            end % iter loop
        end % function


        function obj = mtraine(obj, data, labels, m)
            maxepoch = 2000;
            numFeature = size(data, 2);
            numRow = size(data, 1);
            obj.w = rand(numFeature + 1, 1); % w is a column vector, w(j+1) is intercept
            obj.DELTA = zeros(numRow + 1, numFeature + 1);
            obj.hypo = zeros(numRow, 1);
            E = inf;
            obj.epoch = 0;

            while E > 0.001 && obj.epoch <= maxepoch
                for i = 1:numRow
                    z = [data(i, :), -1] * obj.w;
                    obj.hypo(i) = 1 / (1 + exp(-z)); % hypo is f(X)
                    obj.DELTA(i + 1, 1:numFeature) = - obj.alpha * (obj.hypo(i) - labels(i)) * data(i, :) + m * obj.DELTA(i, 1:numFeature);
                    obj.DELTA(i + 1, numFeature + 1) = obj.alpha * (obj.hypo(i) - labels(i)) + m * obj.DELTA(i, numFeature + 1);
                    obj.w = obj.w + obj.DELTA(i + 1, :)';
                end % i loop

                E = - sum( labels .* log(obj.hypo) + (1-labels) .* log(1-obj.hypo));
                obj.epoch = obj.epoch + 1;
            end % while loop
        end % function

        function obj = traine(obj, data, labels) 
            maxepoch = 2000; % avoid infinite loop
            numFeature = size(data, 2);
            numRow = size(data, 1);
            obj.w = rand(numFeature + 1, 1); % w is a column vector, w(j+1) is intercept
            obj.DELTA = zeros(numRow + 1, numFeature + 1);
            obj.hypo = zeros(numRow, 1);
            E = inf;
            obj.epoch = 0;

            while E > 0.001 && obj.epoch <= maxepoch
                for i = 1:numRow
                    z = [data(i, :), -1] * obj.w;
                    obj.hypo(i) = 1 / (1 + exp(-z)); % hypo is f(X)
                    obj.DELTA(i + 1, 1:numFeature) = - obj.alpha * (obj.hypo(i) - labels(i)) * data(i, :);
                    obj.DELTA(i + 1, numFeature + 1) = obj.alpha * (obj.hypo(i) - labels(i)); 
                    obj.w = obj.w + obj.DELTA(i + 1, :)';
                end % i loop

                E = - sum( labels .* log(obj.hypo) + (1-labels) .* log(1-obj.hypo));
                obj.epoch = obj.epoch + 1;
            end % while loop
        end % function

        function obj = test(obj, data, labels)
            numRow = size(data, 1);
            obj.plabels = ones(numRow, 1);
            z = [data, -ones(numRow, 1)] * obj.w;
            thypo = ones(numRow, 1) ./ (1 + exp(-z));
            for i = 1: numRow
                if thypo(i) <= 0.5 % define the base probability as 50%
                    obj.plabels(i) = 0;
                end % if 
            end % i loop
            res = xor(obj.plabels, labels);
            obj.err = sum(res) / size(res, 1); % error rate
        end % function

    end % methods
end % classdef
                
         
