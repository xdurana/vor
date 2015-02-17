%% Reproducing results of Clopath et al. model of the vestibulo-ocular reflex

%% Detailed model with 100ms delay and cf_vest=0.03 (original)

clear all;
delay = 100;
cf_vest = 0.03;
k = 0;
nit = 1440;
DO_VOR_Clopath14;
VOR_plot;

%% Detailed model with 100ms delay and k=10^-1

clear all;
delay = 100;
cf_vest = 0;
k = 10^-1;
nit = 1440;
DO_VOR_Clopath14;
VOR_plot;

%% Detailed model with 100ms delay and k=10^-2

clear all;
delay = 100;
cf_vest = 0;
k = 10^-2;
nit = 1440;
DO_VOR_Clopath14;
VOR_plot;

%% Detailed model with 100ms delay and k=10^-3

clear all;
delay = 100;
cf_vest = 0;
k = 10^-3;
nit = 1440;
DO_VOR_Clopath14;
VOR_plot;

%% Detailed model with 100ms delay and k=10^-4

clear all;
delay = 100;
cf_vest = 0;
k = 10^-4;
nit = 1440;
DO_VOR_Clopath14;
VOR_plot;

%% Detailed model with 100ms delay and k=10^-5

clear all;
delay = 100;
cf_vest = 0;
k = 10^-5;
nit = 1440;
DO_VOR_Clopath14;
VOR_plot;

%% Detailed model with 100ms delay and k=0

clear all;
delay = 100;
cf_vest = 0;
k = 0;
nit = 1440;
DO_VOR_Clopath14;
VOR_plot;
