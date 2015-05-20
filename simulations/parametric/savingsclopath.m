%% Reproducing results of Clopath et al. model of the vestibulo-ocular reflex

%% Detailed model with 100ms delay with vestibular decay constant = 0.03

clear all;

vor = VOR(100, 0, 0.03);
vor.Period = floor(1000/0.6);
vor.Initialize();

session = Session(vor);
session.SavingsExperiment();
session.simulate();
session.report();