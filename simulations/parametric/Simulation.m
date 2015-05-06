clear all

vor = VOR(100, 0.005);
vor.Period = floor(1000/0.6);
vor.Initialize()

day = 50;
nit = 1440;

session = Session(vor);
session.InitialTrials = 2;

session.add(Trial(1, 1, 200, vor.Period))
session.add(Trial(0, 1, 200, vor.Period))
session.add(Trial(1, 0, 200, vor.Period))
session.add(Trial(0, 1, 200, vor.Period))

session.simulate()
session.polar()
session.wpc()