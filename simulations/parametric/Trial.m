classdef Trial < handle
    properties
        Light;
        Gain;
        Duration;
        Period;
    end
    methods
        function obj = Trial(light, gain, duration, period)
           obj.Light = light;
           obj.Gain = gain;
           obj.Duration = duration;
           obj.Period = period;
        end
        function r = Dt(obj)
            r = obj.Gain*0.25*cos((1+obj.Period*3/4:obj.Period+obj.Period*3/4)*2*pi/obj.Period)+1;
        end
    end
end