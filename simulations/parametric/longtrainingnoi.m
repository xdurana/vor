%% Reproducing results of Clopath et al. model of the vestibulo-ocular reflex

%% Detailed model with 100ms delay and NOI with k=0.01

clear all;

vor = VOR(100, 0.01, 0);
vor.Period = floor(1000/0.6);
vor.Initialize();

session = Session(vor);
session.LongTrainingExperiment();
session.simulate();
session.report();

%% Detailed model with 100ms delay and NOI with k=0.05

clear all;

vor = VOR(100, 0.05, 0);
vor.Period = floor(1000/0.6);
vor.Initialize();

session = Session(vor);
session.LongTrainingExperiment();
session.simulate();
session.report();

%% Detailed model with 100ms delay and NOI with k=0.1

clear all;

vor = VOR(100, 0.1, 0);
vor.Period = floor(1000/0.6);
vor.Initialize();

session = Session(vor);
session.LongTrainingExperiment();
session.simulate();
session.report();