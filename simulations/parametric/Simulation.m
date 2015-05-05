clear all

vor = VOR(100, 0);
vor.Period = floor(1000/0.6);
vor.Initialize()

day = 50;
nit = 1440;

session = Session(vor);
session.add(Trial(1, 1, 200, vor.Period))
session.add(Trial(1, 0, 200, vor.Period))
session.add(Trial(1, -1, 200, vor.Period))

figure;
colors = ['y','g','r','b'];
for i = 2:length(session.Trials)    
    set(polar(session.Trials(i).Phase*2*pi/360, session.Trials(i).Gain), 'color', colors(mod(i-1,4)), 'linewidth', 2);
    hold all;
end

%session.add(Trial(0, 1, 200, vor.Period))
%session.add(Trial(1, 0, 50, vor.Period))
%session.add(Trial(0, 1, 200, vor.Period))
session.simulate()

%session.add(Trial(1, 1, day, vor.Period))
%session.add(Trial(0, 1, 2*nit, vor.Period))
%session.add(Trial(1, 0, day, vor.Period))
%session.add(Trial(0, 1, nit, vor.Period))
%session.add(Trial(1, -0.5, day, vor.Period))
%session.add(Trial(0, 1, nit, vor.Period))
%session.add(Trial(1, -1, day, vor.Period))
%session.add(Trial(0, 1, nit, vor.Period))
%session.add(Trial(1, -1, day, vor.Period))
%session.add(Trial(0, 1, nit, vor.Period))