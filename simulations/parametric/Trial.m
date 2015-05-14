classdef Trial < handle
    properties
        Light
        TargetGain
        Duration
        Period
        
        GCPCWeight
        MFVNWeight
        DError
        CF
        Gain
        Phase
        DPCGain
        DPCPhase
        DVNGain
        DVNPhase
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

        function [gain, phase, g1, g2] = decompose(obj, signal, s1, s2)
            [gain, position] = max(signal);
            gain = gain - mean(signal);
            phase = obj.getphase(position);
            g1 = s1(position);
            g2 = s2(position) - mean(signal);
        end

        function phase = getphase(obj, position)
            phase = (position/obj.Period)*360;
            phase = mod(360-phase-269, 360);
            phase = mod(phase +10, 360)-10;
        end

        function obj = Record(obj, vor)
            obj.GCPCWeight = [obj.GCPCWeight, vor.GCPCWeight];
            obj.MFVNWeight = [obj.MFVNWeight, vor.MFVNWeight];
            obj.DError = [obj.DError, norm(vor.DError)];
            obj.CF = [obj.CF, norm(vor.CF)];
          
            [gain, phase, g1, g2] = obj.decompose(vor.D, vor.DVN, vor.DPC);
            obj.Gain = [obj.Gain, gain];
            obj.Phase = [obj.Phase, phase];
            obj.DVNGain = [obj.DVNGain, g1];
            obj.DPCGain = [obj.DPCGain, g2];
        end

    end
end