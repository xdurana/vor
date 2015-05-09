clear all

vor = VOR(100, 0.005);
vor.Period = floor(1000/0.6);
vor.Initialize()

day = 50;
nit = 1440;

session = Session(vor);
session.InitialTrials = 2;

session.add(Trial(1, 1, day, vor.Period))
session.add(Trial(0, 1, nit, vor.Period))
session.add(Trial(1, 0, day, vor.Period))
session.add(Trial(0, 1, nit, vor.Period))
session.add(Trial(1, -0.5, day, vor.Period))
session.add(Trial(0, 1, nit, vor.Period))
session.add(Trial(1, -1, day, vor.Period))
session.add(Trial(0, 1, nit, vor.Period))
session.add(Trial(1, -1, day, vor.Period))

session.simulate()
session.polarplot()
session.gainplot()
session.wpc()
%session.pca()
