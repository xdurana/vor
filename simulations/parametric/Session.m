classdef Session < handle
    
    properties
        VOR
        Trials
        Duration
        InitialTrials
        
        Gain
        Phase
        GCPCWeight
        MFVNWeight
    end
    
    methods
        
        function obj = Session(VOR)
            obj.VOR = VOR;
            obj.Trials = [];
            obj.Duration = 0;
            obj.InitialTrials = 0;
            obj.Gain = [];
            obj.Phase = [];
            obj.GCPCWeight= [];
            obj.MFVNWeight = [];
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
            for trial = obj.Trials(obj.InitialTrials+1:end)
                trial.Gain = trial.Gain/GainReference;
                obj.Gain = [obj.Gain trial.Gain];                
                obj.Phase = [obj.Phase trial.Phase];
                obj.GCPCWeight = [obj.GCPCWeight, trial.GCPCWeight];
                obj.MFVNWeight = [obj.MFVNWeight, trial.MFVNWeight];
            end
        end
        
        function polar(session)
            figure
            colors = ['y','g','r','b'];
            for i = session.InitialTrials+1:length(session.Trials)
                set(polar(session.Trials(i).Phase*2*pi/360, session.Trials(i).Gain), 'color', colors(mod(i-session.InitialTrials+1,length(colors))+1), 'linewidth', 2)
                hold on
            end
            title('Training sessions')
            hold off
        end
        
        function wpc(session)
            figure
            imagesc(session.GCPCWeight)
            ylabel('Granule cells', 'fontsize', 20)
            xlabel('time [min]', 'fontsize', 20)
            title('Weights on PF-PC synapses')
        end
        
    end
end