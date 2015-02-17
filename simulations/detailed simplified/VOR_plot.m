%%%%%%%%%%%%%%%%%%%% PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % Plot learning
% figure;
% imagesc(D_W);
% %colormap(gray);
% ylabel('Granule cells','fontsize',20);
% xlabel('time [min]','fontsize',20);
% title('Weights on PF-PC synapses');
% 
% % Plot Cf
% figure;
% plot(Cf);
% title('Climbing fiber activity after adaptation');
% 
% % Plot D_E
% figure;
% plot(D_E);
% title('Error');

start_train = day+2*nit;
day1 = start_train + (1:day);
day2 = start_train + ((1*day+1*nit+1):(2*day + 1*nit));
day3 = start_train + ((2*day+2*nit+1):(3*day + 2*nit));
day4 = start_train + ((3*day+3*nit+1):(4*day + 3*nit));

nit1 = start_train + ((1*day+0*nit+1):(1*day + 1*nit));
nit2 = start_train + ((2*day+1*nit+1):(2*day + 2*nit));
nit3 = start_train + ((3*day+2*nit+1):(3*day + 3*nit));

figure;
% Polar plot
h1 = polar(D_P(day1)*2*pi/360, D_G(day1));
set(h1, 'color', 'y', 'linewidth', 2);
hold all;
h2 = polar(D_P(day2)*2*pi/360, D_G(day2));
set(h2, 'color', 'g', 'linewidth', 2);
hold all;
h3 = polar(D_P(day3)*2*pi/360, D_G(day3));
set(h3, 'color', 'r', 'linewidth', 2);
hold all;
h4 = polar(D_P(day4)*2*pi/360, D_G(day4));
set(h4, 'color', 'b', 'linewidth', 2);
legend('day1','day2','day3','day4');
title('Training sessions');

figure;
% Polar plot
n1 = polar(D_P(nit1)*2*pi/360, D_G(nit1));
set(n1, 'color', 'y', 'linewidth', 2);
hold all;
n2 = polar(D_P(nit2)*2*pi/360, D_G(nit2));
set(n2, 'color', 'g', 'linewidth', 2);
hold all;
n3 = polar(D_P(nit3)*2*pi/360, D_G(nit3));
set(n3, 'color', 'r', 'linewidth', 2);
legend('nit1','nit2','nit3','nit4');
title('Blind cycles');

% Plot gain
figure;hold on
plot(day1, D_G(day1), 'g', 'linewidth', 2)
plot(day2, D_G(day2), 'g', 'linewidth', 2)
plot(day3, D_G(day3), 'g', 'linewidth', 2)
plot(day4, D_G(day4), 'g', 'linewidth', 2)
plot(nit1, D_G(nit1), 'b', 'linewidth', 2)
plot(nit2, D_G(nit2), 'b', 'linewidth', 2)
plot(nit3, D_G(nit3), 'b', 'linewidth', 2)
title('Gain');

% Plot gain
figure;hold on
plot(((0*day+1):(1*day)), D_G(day1)', 'g', 'linewidth',2)
plot(((1*day+1):(2*day)), D_G(day2)', 'g', 'linewidth',2)
plot(((2*day+1):(3*day)), D_G(day3)', 'g', 'linewidth',2)
plot(((3*day+1):(4*day)), D_G(day4)', 'g', 'linewidth',2)

plot(1*day+(0:0.1:1.4)*0,0:0.1:1.4, '--k')
plot(2*day+(0:0.1:1.4)*0,0:0.1:1.4, '--k')
plot(3*day+(0:0.1:1.4)*0,0:0.1:1.4, '--k')
xlim([-1 201])
ylabel('gain','fontsize',20);
xlabel('time [min]','fontsize',20);
title('day 1       day 2       day 3       day 4      ','fontsize',20);
set(gca,'fontsize',20);

% Plot phase
figure; hold on;
plot(((0*day+1):(1*day)), D_P(day1)', 'g', 'linewidth',2)
plot(((1*day+1):(2*day)), D_P(day2)', 'g', 'linewidth',2)
plot(((2*day+1):(3*day)), D_P(day3)', 'g', 'linewidth',2)
plot(((3*day+1):(4*day)), D_P(day4)', 'g', 'linewidth',2)

plot(1*day+(-5:355)*0,-5:355, '--k')
plot(2*day+(-5:355)*0,-5:355, '--k')
plot(3*day+(-5:355)*0,-5:355, '--k')
xlim([-1 201])
ylim([-5 180])
ylabel('phase [deg]','fontsize',20);
xlabel('time  [min]','fontsize',20);
title('day 1       day 2       day 3       day 4      ','fontsize',20);
set(gca,'fontsize',20);