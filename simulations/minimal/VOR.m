% This code is written by Xavier Duran, Universitat Pompeu Fabra,
% adapted from Clopath et al. minimal model

% This code calls VOR_minimal.m

% Loop over time
time = T_pat+1:2*T_pat;
Dt = 1 + gain*cos(time*2*pi/T_pat+phit);
D_E = zeros(1,Simul_t);                     % recording error changes

for t = previous_t:Simul_t + previous_t
    P = w_GP' * G;                          % Purkinje cells, G the granuel cells
    D = M - P;
    Cf = light*(Dt-D)+k*P;                  % Climbing Fibers (CF)
    Cf = circshift(Cf,[0,delay]);           % Delay in the CF
    
    % plasticity of G to P synapses
    error = (-1)*sum(((ones(N_inp,1)*Cf)).* G,2);
    w_GP = w_GP + alphai*error; % update
    
    D_E(:,(t-previous_t)+1) = norm(error);
    D_W(:,t) = w_GP;
    
    % record phase and gain of D
    [D_G( t), D_P(t)]=max(D); 
    D_G(t) = D_G(t)-mean(D);
    D_P(t) = mod(D_P(t), T_pat);
end

previous_t = t;