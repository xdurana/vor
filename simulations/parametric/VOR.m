classdef VOR < handle

    properties
        
        D;                          % Motor signal
        DPC;                        % Contribution of PC to motor signal
        DVN;                        % Contribution of VN to motor signal
        GC;                         % Granule Cells signal
        IN;                         % Interneurons signal
        MF;                         % Mossy Fibers signal
        CF;                         % Climbing Fibers signal
        PC;                         % Purkinje Cell signal

        GCPCWeightInitial;          % Initial Weight from Granule Cells to Purkinje
        GCPCWeight;                 % Weight from Granule Cells to Purkinje
        MFVNWeight;                 % Weight from Mossy Fibers to Medial Vestibular Nuclei 
        PCMean;                     % Purkinje Cell signal mean value
        DError;                     % Error difference between D and Dtarget

        CFVestibular;               % Climbing Fiber to Vestibular Nuclei
        PCNOIK;                     % NOI
        Delay;                      % Delay of Climbing Fibers signal
        NOIBaseline;                % NOI from PC baseline
        
        GCNumber = 100;             % Number of Granule Cells (GC)
        DMean = 2.25;               % Medial Vestibular Nuclei cells signal mean value
        MFMean = 0.25;              % Mossy Fibers signal mean value
        GCPCUpperBound = 2.85;      % Upper bound of plasticity at the Granule Cells to Purkinje
        GCPCLowerBound = 0.85;      % Lower bound of plasticity at the Granule Cells to Purkinje

        GCPCAlpha = 3.5e-07;        % Learning rate for GCPCWeight learning term        
        MFVNAlpha = 5.6022e-06;     % Learning rate for MFVNWeight

        MFVNWeightInitial = 0.88;   % Initial Weight from Mossy Fibers to Medial Vestibular Nuclei 
        INPCWeight = 1;             % Fixed Interneurons Weight
                
        CFNoise = 3.5;              % Noise in Climbing Fibers
        GCPCForgettingAlpha = 7.4697e-05;  % learning rate for GCPCWeight forgetting term

        Period = floor(1000/0.6);   % Time of a cycles [ms]

    end

    methods

        function obj = VOR(Delay, PCNOIK, CFVestibular, NOIBaseline)
            obj.Delay = Delay;
            obj.PCNOIK = PCNOIK;
            obj.CFVestibular = CFVestibular;
            obj.NOIBaseline = NOIBaseline;
        end
        
        function obj = Initialize(obj)
            obj.GC = zeros(obj.GCNumber, obj.Period);
            dist = (0.1886*cos((1+obj.GCNumber:2*obj.GCNumber)*2*pi/obj.GCNumber))+(1:obj.GCNumber)*2*pi/obj.GCNumber;
            for i = 1:obj.GCNumber
                obj.GC(i,:) = (cos((obj.Period+1:2*obj.Period)*2*pi/obj.Period-dist(i))+1);
            end
            obj.IN = 2.5/obj.GCNumber*sum(obj.GC);
            obj.IN = obj.IN - mean(obj.IN) + 0.85;
            obj.MFVNWeight = obj.MFVNWeightInitial;
            obj.GCPCWeightInitial = 1.85/obj.GCNumber;
            obj.GCPCWeight = obj.GCPCWeightInitial*ones(obj.GCNumber,1);
            obj.PCMean = obj.GCPCWeight' * obj.GC - obj.INPCWeight' * obj.IN;
            obj.MF = 0.25*cos((1+obj.Period*3/4:obj.Period+obj.Period*3/4)*2*pi/obj.Period)+obj.MFMean;
        end

        function obj = train(obj, trial)

            for t = 1:trial.Duration

                % Purkinje cell
                obj.PC = obj.GCPCWeight' * obj.GC - obj.INPCWeight' * obj.IN;

                % Medial Vestibular Nuclei cells
                obj.DPC = - obj.PC;
                
                obj.DVN = obj.DMean - obj.MF + obj.MFVNWeight*2*(obj.MF-obj.MFMean);
                
                obj.D = obj.DMean - obj.PC - obj.MF + obj.MFVNWeight*2*(obj.MF-obj.MFMean);
                
                % Climbing Fibers
                obj.DError = trial.Dt() - obj.D;
                obj.CF = trial.Light*obj.DError;
                obj.CF = obj.CF + (obj.MF - obj.MFMean)*obj.CFVestibular;
                obj.CF = obj.CF + obj.PCNOIK*obj.PC;
                
                if obj.NOIBaseline
                    obj.CF = obj.CF + obj.PCNOIK*(obj.PC - obj.PCMean);
                else
                    obj.CF = obj.CF + obj.PCNOIK*obj.PC;
                end
                
                obj.CF = circshift(obj.CF,[0,obj.Delay]);

                % Plasticity of GC to PC synapses
                obj.GCPCWeight = obj.GCPCWeight + obj.GCPCAlpha * (-1) * sum(((ones(obj.GCNumber,1)*obj.CF) + obj.CFNoise*randn(obj.GCNumber, obj.Period)).* obj.GC, 2);
                aux = obj.GCPCLowerBound/obj.GCNumber;
                obj.GCPCWeight = (obj.GCPCWeight - aux).*((obj.GCPCWeight - aux) > 0) + aux;
                aux = obj.GCPCUpperBound/obj.GCNumber;
                obj.GCPCWeight = (obj.GCPCWeight - aux).*((obj.GCPCWeight - aux) < 0) + aux;

                % Update decay on PF-PC synapses
                obj.GCPCWeight = obj.GCPCWeight + obj.GCPCForgettingAlpha * (obj.GCPCWeightInitial - obj.GCPCWeight);

                % Plasticity of MF to MVM synapses
                obj.MFVNWeight = obj.MFVNWeight + obj.MFVNAlpha * sum((-obj.MF + obj.MFMean).*(obj.PC - obj.PCMean));
                obj.MFVNWeight = obj.MFVNWeight * (obj.MFVNWeight > 0);
               
                % Save current state for tracking
                trial.Record(obj);
            end
        end
        
        function plotcontribution(vor)                        
            figure;
            hold on;
            plot(vor.D, 'g');
            plot(vor.DMean - vor.PC - vor.MF, 'r');
            plot(vor.MFVNWeight*2*(vor.MF-vor.MFMean), 'b');
            hold off;
        end
        
    end
end