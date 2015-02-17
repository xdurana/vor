%% Adding forgetting from NOI on the Clopath et al. minimal model of the vestibulo-ocular reflex
%% Minimal model with delay=100, k=0.03 and almost no dark time between adaptations

clear all;
delay = 100;
k = 0.03;
nit = 50;
DO_VOR_Clopath14;
VOR_plot;

%% Minimal model with delay=100, k=0.03 and 1440 cycles of dark time between adaptations

clear all;
delay = 100;
k = 0.03;
nit = 1440;
DO_VOR_Clopath14;
VOR_plot;

%% Minimal model with delay=100, k=0.03 and 5760 cycles of dark time between adaptations

clear all;
delay = 100;
k = 0.03;
nit = 5760;
DO_VOR_Clopath14;
VOR_plot;
