classdef Trial < handle
    properties
        Light;
        TargetGain;
        Duration;
        Period;
        
        GCPCWeight;
        MFVNWeight;
        DError;
        CF;
        Gain;
        Phase;
    end
    methods
        function obj = Trial(light, targetgain, duration, period)
           obj.Light = light;
           obj.TargetGain = targetgain;
           obj.Duration = duration;
           obj.Period = period;
           obj.GCPCWeight = [];
        end
        function r = Dt(obj)
            r = obj.TargetGain*0.25*cos((1+obj.Period*3/4:obj.Period+obj.Period*3/4)*2*pi/obj.Period)+1;
        end
        function obj = Record(obj, vor)
            obj.GCPCWeight = [obj.GCPCWeight, vor.GCPCWeight];
            obj.MFVNWeight = [obj.MFVNWeight, vor.MFVNWeight];
            obj.DError = [obj.DError, norm(vor.DError)];
            obj.CF = [obj.CF, norm(vor.CF)];
            [gain, phase] = max(vor.D);
            
            phase = (phase/obj.Period)*360;
            phase = mod(360-phase-269, 360);
            phase = mod(phase +10, 360)-10;                            
            
            obj.Gain = [obj.Gain, gain - mean(vor.D)];
            obj.Phase = [obj.Phase, phase]; 
        end
    end
end