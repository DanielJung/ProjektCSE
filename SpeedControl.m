classdef SpeedControl

    properties
            time        % Time-Vector
            coeffMat    % Coeff-Matrix
    end
    
    methods
        function this=SpeedControl(timearr, speed)
            this.time = timearr;
            this.coeffMat = getSplineCoefficients(this.time, speed, 0, 0);
        end
        function [v] = getSpeed(this, t)
            if (t<this.time(begin)) || (t>this.time(end))
                error('Error SpeedControl: t out of bounds');
            end
            v = evalSpline(this.coeffMat, this.time, t);
        end
    end
    
end

