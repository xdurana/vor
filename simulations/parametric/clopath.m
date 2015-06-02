%% Reproducing results of Clopath et al. model of the vestibulo-ocular reflex

%% Detailed model with 100ms delay and vestibular decay constant = 0.03

clear all;

vor = VOR(100, 0, 0.03, false);
vor.Period = floor(1000/0.6);
vor.Initialize();

session = Session(vor);
session.WulffExperiment();
session.simulate();
session.report();

%% Detailed model with 100ms delay without vestibular decay (H=0) and with alpha_d=0

clear all;

vor = VOR(100, 0, 0, false);
vor.Period = floor(1000/0.6);
vor.GCPCForgettingAlpha = 0;
vor.Initialize();

session = Session(vor);
session.WulffExperiment();
session.simulate();
session.report();