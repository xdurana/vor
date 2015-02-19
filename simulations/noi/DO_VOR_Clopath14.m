% This code is written by Claudia Clopath, Imperial College London %
% Please cite: Clopath et al. Journal of Neuroscience 2014
% "A Cerebellar Learning Model of Vestibulo-Ocular Reflex
% Adaptation in Wild-Type and Mutant Mice"

% This code calls VOR.m

% Parameters
N_inp = 100;                        % number of Granule cells
BH = 2.85;                          % upper bound of plasticity at the Granule Cells to Purkinje
BL = 0.85;                          % lower bound of plasticity at the Granule Cells to Purkinje
CF_noise = 3.5;                     % noise in Climbing Fibers (CF)
w_IP = 1;                           % fixed weight from interneuron to Purkinje cells
w_MD = 0.88;                        % initial Mossy Fiber to MVN weight
win = 1.85/N_inp;                   % initial weight from Granule Cells to Purkinje
w_GP = win*ones(N_inp,1);           % weight from Granule Cells to Purkinje

% Simulation parameters
T_pat = floor(1000/0.6);            % Time of a cycles [ms]
Ntot = day*5+nit*5;                 % total simulating time
D_P = zeros(Ntot,1);                  % recording phase of the eye movement
D_G = zeros(Ntot,1);                  % recording gain of the eye movement
D_W = zeros(N_inp,Ntot);
D_M = zeros(N_inp,1);
previous_t = 1;                     % start simulating time at 1

% Learning rates
alphai = 3.5000e-07;                % learning rate for w_GP learning term
alphad = 5.6022e-06;                % learning rate for w_MD
    
%%%%%%%%%%%%%%%%%%%%%%%%%%% Generate neuronal firing rates %%%%%%%%%%%
% Granule Cells G
G = zeros(N_inp, T_pat);
dist = (0.1886*cos((1+N_inp:2*N_inp)*2*pi/N_inp))+(1:N_inp)*2*pi/N_inp; % over distribution of Granule cells firing at certain phases
for i = 1:N_inp
    G(i,:)= (cos((T_pat+1:2*T_pat)*2*pi/T_pat-dist(i))+1);
end

% Interneuron In
In = 2.5/N_inp *sum(G);
In = In -mean(In)+0.85;

% Compute baseline firing rate of Purkinje cells, P
Pmean = win*ones(N_inp,1)'* G - w_IP'* In;

% Mossy Fibers, M
Mmean = 0.25;   % mean firing rate of M
M = 0.25*cos((1+T_pat*3/4:T_pat+T_pat*3/4)*2*pi/T_pat)+Mmean;

%%%%%%%%%%%%%%%%%%%%%%%%%%% START SIMULATION OVER  TIME %%%%%%%%%%%%%%%%
% Initial phase before training
% Day before train
light = 1;      % in the light condition
gain =1;        % target gain 
Simul_t = day;  % simulating time
VOR             % call the function VOR that loop over time

% Night before training
light = 0;      % in the dark
gain =1;
Simul_t = 2*nit;
VOR

% Start of the training
% Day 1
light = 1;
gain = 0;
Simul_t = day;
VOR

%Night 1
light = 0;
gain =1;
Simul_t = nit;
VOR

% Day 2
light = 1;
gain =-0.5;
Simul_t = day;
VOR

% Night 2
light = 0;
gain =1;
Simul_t = nit;
VOR

% Day 3
light = 1;
gain =-1;
Simul_t = day;
VOR

% Night 3
light = 0;
gain =1;
Simul_t = nit;
VOR

% Day 4
light = 1;
gain =-1;
Simul_t = day;
VOR

%%%%%%%%%%%%%%%%%%%% PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Renormalise phase and gain
D_G(:)= D_G(:)/D_G(2*nit);
D_P = (D_P /T_pat)*360;
D_P = mod(360-D_P -269, 360);
D_P = mod(D_P +10, 360)-10;