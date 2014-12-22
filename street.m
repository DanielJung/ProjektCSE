classdef street
    
    properties (GetAccess=public)
        CoeffMatX   % Coefficient-Matrix for X-Axis
        dCoeffMatX  % Coefficient-Matrix for derivate X
        CoeffMatY   % Coefficient-Matrix for Y-Axis
        dCoeffMatY  % Coefficient-Matrix for derivate Y
        Time        % Time-Interval
        DeltaT      % Time-Step
        NumSteps    % Number of Steps
        CurTime     % Current Time
        CurPos      % Current Position
        Rotation    % Current Rotation
        frame       % an welcher Stelle der Straﬂe befindet man sich (Nummer der koordinate)
    end
    
    methods
        function this=street(x, y, dt)
            this.Time           = 0:length(x)-1;
            this.DeltaT         = dt;
            this.CurTime        = 0;
            this.NumSteps       = (length(this.Time)-1)/this.DeltaT;
            this.CurPos(1)      = x(1);
            this.CurPos(2)      = y(1);
            this.frame          = 1;
            this.CoeffMatX      = getSplineCoefficients(this.Time, x, 0, 0);
            this.CoeffMatY      = getSplineCoefficients(this.Time, y, 0, 0);
            
            this.dCoeffMatX     = diffCoeffMat(this.CoeffMatX);
            this.dCoeffMatY     = diffCoeffMat(this.CoeffMatY);
        end
        function this=step(this, v)
            this.CurTime = this.CurTime + this.DeltaT*v;
            dx = evalSpline(this.dCoeffMatX, this.Time, this.CurTime);
            dy = evalSpline(this.dCoeffMatY, this.Time, this.CurTime);
            this.CurPos(1) = this.CurPos(1)+v*this.DeltaT*dx;
            this.CurPos(2) = this.CurPos(2)+v*this.DeltaT*dy;
            this.Rotation = atan2(dy, dx)-pi;
            this.frame  = this.frame+v;
            
        end
        function [t, x, y, xr, yr, xl, yl] = getRouting(this, numSteps, width)
            t = linspace(0, max(this.Time), numSteps);
            x = zeros(numSteps, 1);
            xr = zeros(numSteps, 1);
            xl = zeros(numSteps, 1);
            y = zeros(numSteps, 1);
            yr = zeros(numSteps, 1);
            yl = zeros(numSteps, 1);
            alpha = zeros(numSteps,1);
            for i=1:length(t)
                x(i, 1) = evalSpline(this.CoeffMatX, this.Time, t(i));
                y(i, 1) = evalSpline(this.CoeffMatY, this.Time, t(i));
                
                dx = evalSpline(this.dCoeffMatX, this.Time, t(i));
                dy = evalSpline(this.dCoeffMatY, this.Time, t(i));
                %Winkel berenchen
                xy(1, 1) = x(i);
                xy(2, 1) = y(i);
                xy = xy/norm(xy);
                e_y=[0 1];
                
                %Berechne rechten Rand
                xy = [0;0];
                xy(1, 1) = dy;
                xy(2, 1) = -dx;
                xy = xy/norm(xy)*width/2;
                
                xr(i, 1) = x(i, 1)+xy(1, 1);
                yr(i, 1) = y(i, 1)+xy(2, 1);
                
                %Berechne linken Rand
                xy(1, 1) = -dy;
                xy(2, 1) = dx;
                xy = xy/norm(xy)*width/2;
                
                xl(i, 1) = x(i, 1)+xy(1, 1);
                yl(i, 1) = y(i, 1)+xy(2, 1);
            end
        end
        function [x] = getPosition2D(this)
            x = [this.CurPos(1), this.CurPos(2)];
        end
        
        function [x] = getPosition(this)
            x = [this.CurPos(1), 0.03, this.CurPos(2)];
        end
        function [a] = getRotation(this)
            a = this.Rotation;
        end
        function [b] = getFrame(this)
                b = this.frame;
        end
            
        function [dx, dy] = getDerivative(this, numSteps)
            t = linspace(0, max(this.Time), numSteps);
            dx = zeros(numSteps, 1);
            dy = zeros(numSteps, 1);
            for i=1:length(t)
                dx(i) = evalSpline(this.dCoeffMatX, this.Time, t(i));
                dy(i) = evalSpline(this.dCoeffMatY, this.Time, t(i));
            end
        end
     
    
end
end
