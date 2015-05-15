%% Reproducing results of Clopath et al. model of the vestibulo-ocular reflex

%% Detailed model with 100ms delay and cf_vest=0.03 (original)

clear all;

vor = VOR(100, 2, 0.00);
vor.Period = floor(1000/0.6);
vor.Initialize();

day = 50;
nit = 200;

session = Session(vor);
session.InitialTrials = 2;

session.add(Trial(1, 1, day, vor.Period));
session.add(Trial(0, 1, nit, vor.Period));
session.add(Trial(1, 0, day, vor.Period));
session.add(Trial(0, 1, nit, vor.Period));

session.simulate();
session.polarplot();
session.gainplot();
session.gainplotdecomposed();
session.wpc();
%session.pca();
