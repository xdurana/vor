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

        function [gain, phase, g1, g2] = decomposeVNPC(obj, signal, vn, pc)
            [gain, position] = max(signal);
            gain = gain - mean(signal);
            phase = obj.getphase(position);
            g1 = vn(position) - mean(vn);
            g2 = pc(position) - mean(pc);
        end

        function [gain, phase] = decompose(obj, signal)
            [gain, position] = max(signal);
            gain = gain - mean(signal);
            phase = obj.getphase(position);
        end

        function phase = getphase(obj, position)
            phase = (position/obj.Period)*360;
            phase = mod(360-phase-269, 360);
            phase = mod(phase + 10, 360) - 10;
        end
        
        function polar(obj, i)
            figure;
            
            max_lim = 1;
            x_fake = [0 max_lim 0 -max_lim];
            y_fake = [max_lim 0 -max_lim 0];
            set(polar(x_fake, y_fake), 'Visible', 'off', 'HandleVisibility','off');            
            hold on;
            
            set(polar(obj.Phase(1)*2*pi/360, obj.Gain(1), '-og'), 'linewidth', 2, 'HandleVisibility','off')
            hold on
            set(polar(obj.Phase*2*pi/360, obj.Gain, 'g'), 'linewidth', 2, 'DisplayName', 'total')
            hold on
            set(polar(obj.DPCPhase(1)*2*pi/360, obj.DPCGain(1), '-or'), 'linewidth', 2, 'HandleVisibility','off')
            hold on
            set(polar(obj.DPCPhase*2*pi/360, obj.DPCGain, 'r'), 'linewidth', 2, 'DisplayName', 'cortical')
            hold on
            set(polar(obj.DVNPhase(1)*2*pi/360, obj.DVNGain(1), '-ob'), 'linewidth', 2, 'HandleVisibility','off')
            hold on
            set(polar(obj.DVNPhase*2*pi/360, obj.DVNGain, 'b'), 'linewidth', 2, 'DisplayName', 'vestibular')
            hold on
            
            legend('-DynamicLegend', 'Location','southoutside','Orientation','vertical');
            if (obj.Light)
                title(sprintf('%d. Training session of gain %f (%d min)', i, obj.TargetGain, obj.Duration))
            else
                title(sprintf('%d. Light deprivation session (%d min)', i, obj.Duration))
            end
            hold off
        end

        function obj = Record(obj, vor)
            obj.GCPCWeight = [obj.GCPCWeight, vor.GCPCWeight];
            obj.MFVNWeight = [obj.MFVNWeight, vor.MFVNWeight];  
            
            obj.DError = [obj.DError, norm(vor.DError)];
            obj.CF = [obj.CF, norm(vor.CF)];
                
            %[gain, phase, g1, g2] = obj.decomposeVNPC(vor.D, vor.DVN, vor.DPC);

            [gain, phase] = obj.decompose(vor.D);
            obj.Gain = [obj.Gain, gain];
            obj.Phase = [obj.Phase, phase];
            
            [gain, phase] = obj.decompose(vor.DVN);
            obj.DVNGain = [obj.DVNGain, gain];
            obj.DVNPhase = [obj.DVNPhase, phase];
                        
            [gain, phase] = obj.decompose(vor.DPC);
            obj.DPCGain = [obj.DPCGain, gain];
            obj.DPCPhase = [obj.DPCPhase, phase];
        end
        
        function plotreflex(obj, vor)
            figure
            plot(obj.Dt(), 'r')
            hold on
            plot(vor.D, 'b')
            hold off
        end
        
    end
end