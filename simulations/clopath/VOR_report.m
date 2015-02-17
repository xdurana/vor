%% Reproducing results of Clopath et al. model of the vestibulo-ocular reflex
%% Minimal model without delay

clear all;
delay = 0;
DO_VOR_Clopath14_minimal;
VOR_minimal_plot;

%% Minimal model with 50ms delay

clear all;
delay = 50;
DO_VOR_Clopath14_minimal;
VOR_plot;

%% Minimal model with 100ms delay

clear all;
delay = 100;
DO_VOR_Clopath14_minimal;
VOR_minimal_plot;

%% Minimal model with 200ms delay

clear all;
delay = 200;
DO_VOR_Clopath14_minimal;
VOR_minimal_plot;

%% Detailed model with 100ms delay

clear all;
delay = 100;
DO_VOR_Clopath14;
VOR_minimal_plot;
