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
        DError
        CF
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

        function MinimalExperiment(session)            
            day = 50;
            nit = 100;
            session.InitialTrials = 1;            
            for i=1:5
                session.add(Trial(1, 1, 5*day, session.VOR.Period));
                session.add(Trial(0, 1, 5*nit, session.VOR.Period));
                session.add(Trial(1, 0, 5*day, session.VOR.Period));
                session.add(Trial(0, 1, 5*nit, session.VOR.Period));
            end
        end
        
        function WulffExperiment(session)            
            day = 50;
            nit = 1440;
            session.InitialTrials = 2;
            session.add(Trial(1, 1, day, session.VOR.Period));
            session.add(Trial(0, 1, 2*nit, session.VOR.Period));
            session.add(Trial(1, 0, day, session.VOR.Period));
            session.add(Trial(0, 1, nit, session.VOR.Period));
            session.add(Trial(1, -0.5, day, session.VOR.Period));
            session.add(Trial(0, 1, nit, session.VOR.Period));
            session.add(Trial(1, -1, day, session.VOR.Period));
            session.add(Trial(0, 1, nit, session.VOR.Period));
            session.add(Trial(1, -1, day, session.VOR.Period));
        end
        
        function LongDarkExperiment(session)
            day = 50;
            nit = 1440;
            session.InitialTrials = 2;
            session.add(Trial(1, 1, day, session.VOR.Period));
            session.add(Trial(0, 1, 2*nit, session.VOR.Period));
            session.add(Trial(1, 0, day, session.VOR.Period));
            session.add(Trial(0, 1, 7*nit, session.VOR.Period));
        end
        
        function LongerDarkExperiment(session)
            day = 50;
            nit = 1440;
            session.InitialTrials = 2;
            session.add(Trial(1, 1, 7*day, session.VOR.Period));
            session.add(Trial(0, 1, 7*nit, session.VOR.Period));
            session.add(Trial(1, 0, 7*day, session.VOR.Period));
            session.add(Trial(0, 1, 7*nit, session.VOR.Period));
        end
        
        function LongTrainingExperiment(session)
            day = 1440;
            nit = 1440;
            session.InitialTrials = 2;
            session.add(Trial(1, 1, day, session.VOR.Period));
            session.add(Trial(0, 1, nit, session.VOR.Period));
            session.add(Trial(1, 0, day, session.VOR.Period));
            session.add(Trial(0, 1, nit, session.VOR.Period));
            session.add(Trial(1, 1, day, session.VOR.Period));
            session.add(Trial(0, 1, nit, session.VOR.Period));
        end
        
        function SavingsExperiment(session)
            short = 50;
            longs = 1440;
            session.InitialTrials = 2;
            session.add(Trial(1, 1, short, session.VOR.Period));
            session.add(Trial(0, 1, short, session.VOR.Period));
            session.add(Trial(1, 1, short, session.VOR.Period));
            session.add(Trial(0, 1, longs, session.VOR.Period));
            session.add(Trial(1, 0, longs, session.VOR.Period));
            session.add(Trial(0, 1, longs, session.VOR.Period));
            session.add(Trial(1, 1, longs, session.VOR.Period));
            session.add(Trial(0, 1, longs, session.VOR.Period));
            session.add(Trial(1, 1, longs, session.VOR.Period));
            session.add(Trial(0, 1, longs, session.VOR.Period));
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
                obj.DError = [obj.DError, trial.DError];
                obj.CF = [obj.CF, trial.CF];
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
        
        function polarplotpertrials(session)
            for i = session.InitialTrials+1:length(session.Trials)
                session.Trials(i).polar(i-session.InitialTrials)
            end
        end
        
        function gainplot(session)
            figure
            hold on
            start = 1;            
            for i = session.InitialTrials+1:length(session.Trials)
                if (session.Trials(i).Light)
                    plot(start:start+length(session.Trials(i).Gain)-1, session.Trials(i).Gain, 'g', 'linewidth', 2)
                    plot(start:start+length(session.Trials(i).DPCGain)-1, session.Trials(i).DPCGain, 'y', 'linewidth', 2)
                    plot(start:start+length(session.Trials(i).DVNGain)-1, session.Trials(i).DVNGain, 'b', 'linewidth', 2)
                    start = start + length(session.Trials(i).Gain);
                    plot(start-1+(0:0.1:1.4)*0,0:0.1:1.4, '--k')
                end
            end
            legend('total', 'cortical', 'vestibular');
            ylabel('gain','fontsize',20);
            xlabel('time [min]','fontsize',20);
            title('Gain evolution during the training sessions')
            hold off
        end
        
        function phaseplot(session)
            figure
            hold on
            start = 1;           
            for i = session.InitialTrials+1:length(session.Trials)
                if (session.Trials(i).Light)
                    plot(start:start+length(session.Trials(i).Phase)-1, session.Trials(i).Phase, 'g', 'linewidth', 2)
                    start = start + length(session.Trials(i).Phase);
                    plot(start-1+(-5:355)*0,(-5:355), '--k')
                end
            end
            ylim([-5 180])
            ylabel('phase','fontsize',20);
            xlabel('time [min]','fontsize',20);
            title('Phase evolution during the training sessions')
            hold off
        end
        
        function gainplotdecomposed(session)
            figure
            hold on
            start = 1;            
            for i = session.InitialTrials+1:length(session.Trials)
                if (1 || session.Trials(i).Light)
                    plot(start:start+length(session.Trials(i).Gain)-1, session.Trials(i).Gain, 'g', 'linewidth', 2)
                    plot(start:start+length(session.Trials(i).DPCGain)-1, session.Trials(i).DPCGain, 'y', 'linewidth', 2)
                    plot(start:start+length(session.Trials(i).DVNGain)-1, session.Trials(i).DVNGain, 'b', 'linewidth', 2)
                    start = start + length(session.Trials(i).Gain);
                    plot(start-1+(0:0.1:1.4)*0,0:0.1:1.4, '--k')
                end
            end
            legend('total', 'cortical', 'vestibular');
            ylabel('gain','fontsize',20);
            xlabel('time [min]','fontsize',20);
            title('Gain evolution')
            hold off
        end
        
        function wpc(session)
            figure
            imagesc(session.GCPCWeight)
            ylabel('Granule cells', 'fontsize', 20)
            xlabel('time [min]', 'fontsize', 20)
            title('Weights on PF-PC synapses')
        end
        
        function wvn(session)
            figure
            plot(session.MFVNWeight);
            ylabel('Weight', 'fontsize', 20)
            xlabel('time [min]', 'fontsize', 20)
            title('Weight on MF-VN synapse')
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
        
        function report(session)
            session.wpc();
            session.wvn();
            session.polarplot();
            session.polarplotpertrials();
            session.gainplot();
            %session.phaseplot();
            session.gainplotdecomposed();
            %session.pca();
        end
    end
end