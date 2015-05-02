classdef Trial < handle
    properties
        Light;
        Gain;
        Duration;
        Period;
        
        GCPCWeight;
        MFVNWeight;
        DError;
        CF;
    end
    methods
        function obj = Trial(light, gain, duration, period)
           obj.Light = light;
           obj.Gain = gain;
           obj.Duration = duration;
           obj.Period = period;
           obj.GCPCWeight = [];
        end
        function r = Dt(obj)
            r = obj.Gain*0.25*cos((1+obj.Period*3/4:obj.Period+obj.Period*3/4)*2*pi/obj.Period)+1;
        end
        function obj = Record(obj, vor)
            obj.GCPCWeight = [obj.GCPCWeight, vor.GCPCWeight];
            obj.MFVNWeight = [obj.MFVNWeight, vor.MFVNWeight];
            obj.DError = [obj.DError, norm(vor.DError)];
            obj.CF = [obj.CF, norm(vor.CF)];
        end
    end
end