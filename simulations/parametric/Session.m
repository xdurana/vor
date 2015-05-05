classdef Session < handle
    
    properties
        VOR;
        Trials;
        Duration;
        Gain;
        Phase;
    end
    
    methods
        
        function obj = Session(VOR)
            obj.VOR = VOR;
            obj.Trials = [];
            obj.Duration = 0;
            obj.Gain = [];
            obj.Phase = [];
        end        
        
        function obj = add(obj, trial)
            obj.Trials = [obj.Trials, trial];
            obj.Duration = obj.Duration + trial.Duration;
        end
        
        function obj = simulate(obj)
            for trial = obj.Trials
                obj.VOR.train(trial);
            end
            
            GainReference = obj.Trials(1).Gain(end);
            for trial = obj.Trials(2:end)
                trial.Gain = trial.Gain/GainReference;
                obj.Gain = [obj.Gain trial.Gain];                
                obj.Phase = [obj.Phase trial.Phase];         
            end
        end
    end
end