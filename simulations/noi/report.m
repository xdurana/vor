%% Reproducing results of Clopath et al. model of the vestibulo-ocular reflex

%% Detailed model with 100ms delay and cf_vest=0.03 (original)

clear all;
delay = 100;
cf_vest = 0.03;
k = 0;
day = 50;
nit = 200;
alphaf = 7.4697e-05;
DO_VOR_Clopath14;
VOR_plot;

%% Detailed model with 100ms delay and k=0.1

clear all;
delay = 100;
cf_vest = 0;
k = 0.1;
day = 50;
nit = 200;
alphaf = 0;
DO_VOR_Clopath14;
VOR_plot;

%% Detailed model with 100ms delay and k=0.01

clear all;
delay = 100;
cf_vest = 0;
k = 0.01;
day = 50;
nit = 200;
alphaf = 0;
DO_VOR_Clopath14;
VOR_plot;

%% Detailed model with 100ms delay and k=0.001

clear all;
delay = 100;
cf_vest = 0;
k = 0.001;
day = 50;
nit = 200;
alphaf = 0;
DO_VOR_Clopath14;
VOR_plot;

%% Detailed model with 100ms delay and k=0

clear all;
delay = 100;
cf_vest = 0;
k = 0;
day = 50;
nit = 200;
alphaf = 0;
DO_VOR_Clopath14;
VOR_plot;