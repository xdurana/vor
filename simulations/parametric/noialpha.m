%% Reproducing results of Clopath et al. model of the vestibulo-ocular reflex
% All the simulations are without vestibular decay (H=0) and with alpha_d>0

%% Detailed model with 100ms delay and NOI with k=0.005

clear all;

vor = VOR(100, 0.005, 0, false);
vor.Period = floor(1000/0.6);
vor.Initialize();

session = Session(vor);
session.WulffExperiment();
session.simulate();
session.report();

%% Detailed model with 100ms delay and NOI with k=0.01

clear all;

vor = VOR(100, 0.01, 0, false);
vor.Period = floor(1000/0.6);
vor.Initialize();

session = Session(vor);
session.WulffExperiment();
session.simulate();
session.report();

%% Detailed model with 100ms delay and NOI with k=0.025

clear all;

vor = VOR(100, 0.025, 0, false);
vor.Period = floor(1000/0.6);
vor.Initialize();

session = Session(vor);
session.WulffExperiment();
session.simulate();
session.report();

%% Detailed model with 100ms delay and NOI with k=0.05

clear all;

vor = VOR(100, 0.05, 0, false);
vor.Period = floor(1000/0.6);
vor.Initialize();

session = Session(vor);
session.WulffExperiment();
session.simulate();
session.report();

%% Detailed model with 100ms delay and NOI with k=0.1

clear all;

vor = VOR(100, 0.1, 0, false);
vor.Period = floor(1000/0.6);
vor.Initialize();

session = Session(vor);
session.WulffExperiment();
session.simulate();
session.report();