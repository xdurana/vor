
vor = VOR();
vor.Period = floor(1000/0.6);
vor.Initialize();

trial = Trial(0, 1, 400, vor.Period);
vor.Train(trial);