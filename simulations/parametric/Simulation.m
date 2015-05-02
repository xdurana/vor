
vor = VOR(100, 0.005);
vor.Period = floor(1000/0.6);
vor.Initialize();

day = 50;
nit = 1440;

vor.train(Trial(1, 0, 1000, vor.Period));

trialD0 = Trial(1, 1, day, vor.Period);
trialN0 = Trial(0, 1, 2*nit, vor.Period);

trialD1 = Trial(1, 0, day, vor.Period);
trialN1 = Trial(0, 1, nit, vor.Period);

trialD2 = Trial(1, -0.5, day, vor.Period);
trialN2 = Trial(0, 1, nit, vor.Period);

trialD3 = Trial(1, -1, day, vor.Period);
trialN3 = Trial(0, 1, nit, vor.Period);

trialD4 = Trial(1, -1, day, vor.Period);
trialN4 = Trial(0, 1, nit, vor.Period);

%vor.Train(trialD0);
%vor.Train(trialN0);
%vor.Train(trialD1);
%vor.Train(trialN1);
%vor.Train(trialD2);
%vor.Train(trialN2);
%vor.Train(trialD3);
%vor.Train(trialN3);
%vor.Train(trialD4);
%vor.Train(trialN4);