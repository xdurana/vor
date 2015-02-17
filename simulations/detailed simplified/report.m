%% Reproducing results of Clopath et al. model of the vestibulo-ocular reflex
%% Detailed model with 100ms delay without forgetting on dark

clear all;
delay = 100;
cf_vest = 0.00;
k = 0.00;
nit = 1440;
DO_VOR_Clopath14;
VOR_plot;

% Detailed model with 100ms delay and cf_vest=0.03

clear all;
delay = 100;
cf_vest = 0.03;
k = 0.00;
nit = 1440;
DO_VOR_Clopath14;
VOR_plot;

% %% Detailed model with 100ms delay and k=0.03

clear all;
delay = 100;
cf_vest = 0;
k = 0.03;
nit = 1440;
DO_VOR_Clopath14;
VOR_plot;