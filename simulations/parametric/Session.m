classdef Session < handle
    
    properties
        VOR
        Trials
        Duration
        InitialTrials
        
        Gain
        Phase
        DPCGain
        DPCPhase
        DVNGain
        DVNPhase
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
            
            GainReference = obj.Trials(obj.InitialTrials).Gain(end);
            for trial = obj.Trials(obj.InitialTrials+1:end)
                
                trial.Gain = trial.Gain/GainReference;
                trial.DPCGain = trial.DPCGain/GainReference;
                trial.DVNGain = trial.DVNGain/GainReference;
                
                obj.Gain = [obj.Gain trial.Gain];                
                obj.Phase = [obj.Phase trial.Phase];
                obj.DPCGain = [obj.DPCGain trial.DPCGain];                
                obj.DVNGain = [obj.DVNGain trial.DVNGain];                
                obj.GCPCWeight = [obj.GCPCWeight, trial.GCPCWeight];
                obj.MFVNWeight = [obj.MFVNWeight, trial.MFVNWeight];
            end
        end
        
        function polarplot(session)
            figure;
            colors = ['g','g','g','g'];
            for i = session.InitialTrials+1:length(session.Trials)
                if session.Trials(i).Light
                    set(polar(session.Trials(i).Phase*2*pi/360, session.Trials(i).Gain), 'color', colors(mod(i-session.InitialTrials+1,length(colors))+1), 'linewidth', 2, 'DisplayName', sprintf('train %.1f', session.Trials(i).TargetGain))
                else
                    set(polar(session.Trials(i).Phase*2*pi/360, session.Trials(i).Gain), 'color', 'r', 'linewidth', 2, 'DisplayName', 'rest')
                end
                hold on
            end
            legend('-DynamicLegend');
            title('Training sessions')
            hold off
        end
        
        function gainplot(session)
            figure
            hold on
            start = 1;            
            for i = session.InitialTrials+1:length(session.Trials)
                if (session.Trials(i).Light)
                    plot(start:start+length(session.Trials(i).Gain)-1, session.Trials(i).Gain, 'g', 'linewidth', 2)
                    start = start + length(session.Trials(i).Gain);
                    plot(start-1+(0:0.1:1.4)*0,0:0.1:1.4, '--k')
                end
            end
            ylabel('gain','fontsize',20);
            xlabel('time [min]','fontsize',20);
            title('Training sessions')
            hold off
        end
        
        function gainplotdecomposed(session)
            figure
            hold on
            start = 1;            
            for i = session.InitialTrials+1:length(session.Trials)
                if (1 || session.Trials(i).Light)
                    plot(start:start+length(session.Trials(i).Gain)-1, session.Trials(i).Gain, 'g', 'linewidth', 2)
                    plot(start:start+length(session.Trials(i).DPCGain)-1, session.Trials(i).DPCGain, 'g--', 'linewidth', 2)
                    plot(start:start+length(session.Trials(i).DVNGain)-1, session.Trials(i).DVNGain, 'g:', 'linewidth', 2)
                    start = start + length(session.Trials(i).Gain);
                    plot(start-1+(0:0.1:1.4)*0,0:0.1:1.4, '--k')
                end
            end
            legend('total', 'cortical', 'vestibular');
            ylabel('gain','fontsize',20);
            xlabel('time [min]','fontsize',20);
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
        
        function pca(obj)
            [coeff, score, ~, ~, ~, mu] = pca(obj.GCPCWeight);
            s1 = score(:,1:1) * coeff(:,1:1)';
            s1 = bsxfun(@plus, mu, s1);
            s2 = score(:,1:4) * coeff(:,1:4)';
            s2 = bsxfun(@plus, mu, s2);
            figure
            imagesc(s1)
            figure
            imagesc(s2)
            figure
            imagesc(obj.GCPCWeight-s1)
            figure
            imagesc(obj.GCPCWeight-s2)
        end        
    end
end