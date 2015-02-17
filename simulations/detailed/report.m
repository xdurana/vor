% Reproducing results of Clopath et al. model of the vestibulo-ocular reflex
% Minimal model without delay and k=0

% clear all;
% delay = 100;
% k = 0.0;
% DO_VOR_Clopath14_minimal;
% VOR_plot;
% 
% % Minimal model with 100ms delay and k=0.01
% 
% clear all;
% delay = 100;
% k = 0.01;
% DO_VOR_Clopath14_minimal;
% VOR_plot;

% % Minimal model with 100ms delay
% 
% clear all;
% delay = 100;
% DO_VOR_Clopath14_minimal;
% VOR_plot;
% 
% % Minimal model with 200ms delay
% 
% clear all;
% delay = 200;
% DO_VOR_Clopath14_minimal;
% VOR_plot;

% Detailed model with 100ms delay and k=0

% clear all;
% delay = 100;
% k = 0.0;
% nit = 1;                         % time of night [unit of cycles]
% DO_VOR_Clopath14;
% VOR_plot;
% 
% clear all;
% delay = 100;
% k = 0.0;
% nit = 1440;                         % time of night [unit of cycles]
% DO_VOR_Clopath14;
% VOR_plot;
% 
clear all;
delay = 100;
k = 0.0;
nit = 2400;                         % time of night [unit of cycles]
DO_VOR_Clopath14;
VOR_plot;

% % Detailed model with 100ms delay and k=0.01
% 
% clear all;
% delay = 100;
% k = 0.01;
% DO_VOR_Clopath14;
% VOR_plot;