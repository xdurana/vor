
%%
% This code is written by Xavier Duran, Universitat Pompeu Fabra,
% adapted from Clopath et al. minimal model

% This code calls VOR_minimal.m

% Parameters
N_inp = 100;                        % number of Granule cells
win = 1.85/N_inp;                   % initial weight from Granule Cells to Purkinje
w_GP = 1.85*rand(N_inp, 1)/N_inp;   % weight from Granule Cells to Purkinje
w_GP = win*ones(N_inp,1);           % weight from Granule Cells to Purkinje

% Simulation parameters
T_pat = floor(1000/0.6);            % Time of a cycles [ms]
day = 50;                           % time of day training [unit of cycles]
Ntot = day*5+nit*5;                 % total simulating time
D_P = zeros(1,Ntot);                % recording phase of the eye movement
D_G = zeros(1,Ntot);                % recording gain of the eye movement
D_W = zeros(N_inp,Ntot);            % recording plasticity changes
previous_t = 1;                     % start simulating time at 1

% Learning rates
%alphai = 1/(15*60*1000);            % learning rate for w_GP learning term
alphai = 3.5000e-07;                % learning rate for w_GP learning term
    
%%%%%%%%%%%%%%%%%%%%%%%%%%% Generate neuronal firing rates %%%%%%%%%%%
% Granule Cells G
G = zeros(N_inp, T_pat);
dist = (1:N_inp)*2*pi/N_inp; % over distribution of Granule cells firing at certain phases
time = (T_pat+1:2*T_pat);
for i = 1:N_inp
    G(i,:) = 1 + cos(time*2*pi/T_pat-dist(i));
end

M = 1 + cos(time*2*pi/T_pat);

%%%%%%%%%%%%%%%%%%%%%%%%%%% START SIMULATION OVER  TIME %%%%%%%%%%%%%%%%
% Initial phase before training
% Day before train
light = 1;      % in the light condition
gain = 1;       % target gain 
phit = 0;       % phase shift
Simul_t = day;  % simulating time
VOR             % call the function VOR that loop over time

% Night before training
light = 0;      % in the dark
gain =1;
phit = 0;
Simul_t = 2*nit;
VOR

% Start of the training
% Day 1
light = 1;
gain = 0;
phit = 0;
Simul_t = day;
VOR

%Night 1
light = 0;
gain =1;
phit = 0;
Simul_t = nit;
VOR

% Day 2
light = 1;
gain =-0.5;
phit = 0;
Simul_t = day;
VOR

% Night 2
light = 0;
gain =1;
phit = 0;
Simul_t = nit;
VOR

% Day 3
light = 1;
gain =-1;
phit = 0;
Simul_t = day;
VOR

% Night 3
light = 0;
gain =1;
phit = 0;
Simul_t = nit;
VOR

% Day 4
light = 1;
gain =-1;
phit = 0;
Simul_t = day;
VOR
VOR_plot_iteration;

% Night 4
light = 0;
gain =1;
phit = 0;
Simul_t = nit;
VOR

% Renormalise phase and gain
D_G(1,:)= D_G(1,:)/D_G(1,2*nit);
D_P = (D_P /T_pat)*360;
D_P = mod(360-D_P, 360);