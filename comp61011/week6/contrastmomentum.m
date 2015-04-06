% Script
% Contrast models with and without momentum
% Evaluated by error rate & epoch (iteration)

% ==== DATAB ====
load datab;
modelb = mylogreg(0.01); % LR = 0.01
% No momentum
modelb = modelb.traine(data, labels);
modelb = modelb.test(data, labels);

% Add momentum
modelb_m = mylogreg(0.01); % LR = 0.01
modelb_m = modelb_m.mtraine(data, labels, 0.5); % MC = 0.5
modelb_m = modelb_m.test(data, labels);


% ==== DATAG ====
load datag;
modelg = mylogreg(0.1); % LR = 0.1
% No momentum
modelg = modelg.traine(data, labels);
modelg = modelg.test(data, labels);

% Add momentum
modelg_m = mylogreg(0.1); % LR = 0.1
modelg_m = modelg_m.mtraine(data, labels, 0.6); % MC = 0.6
modelg_m = modelg_m.test(data, labels);


% ==== HEART ====
load heart;
modelh = mylogreg(0.06); % LR = 0.06
% No momentum
modelh = modelh.traine(data, labels);
modelh = modelh.test(data, labels);

% Add momentum
modelh_m = mylogreg(0.06); % LR = 0.06
modelh_m = modelh_m.mtraine(data, labels, 0.25); % MC = 0.25
modelh_m = modelh_m.test(data, labels);
