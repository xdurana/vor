classdef Session < handle
    
    properties
        VOR;
        Trials;
        Duration;
    end
    
    methods
        
        function obj = Session(VOR)
            obj.VOR = VOR;
            obj.Trials = [];
            obj.Duration = 0;
        end        
        
        function obj = add(obj, trial)
            obj.Trials = [obj.Trials; trial];
            obj.Duration = obj.Duration + trial.Duration;
        end
        
        function obj = simulate(obj)
            for trial = obj.Trials
                obj.VOR.train(trial);
            end
        end
    end
    
end

