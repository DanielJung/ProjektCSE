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
        frame       % an welcher Stelle der Stra�e befindet man sich (Nummer der koordinate)
    end
    
    methods
        function this=street(x, y, dt)
            [x, y] = this.filterPoints(x, y, 0);
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
            this.CurTime = this.CurTime + this.DeltaT;
            dx = evalSpline(this.dCoeffMatX, this.Time, this.CurTime);
            dy = evalSpline(this.dCoeffMatY, this.Time, this.CurTime);
            this.CurPos(1) = this.CurPos(1)+v*this.DeltaT*dx;
            this.CurPos(2) = this.CurPos(2)+v*this.DeltaT*dy;
            this.Rotation = atan2(dy, dx)-pi;
            this.frame  = this.frame+v;
            
        end
        function [t, x, y, xr, yr, xl, yl] = getRouting(this, width)
            numSteps = max(this.Time)/this.DeltaT;
            t = linspace(0, max(this.Time), numSteps);
            x = zeros(numSteps, 1);
            xr = zeros(numSteps, 1);
            xl = zeros(numSteps, 1);
            y = zeros(numSteps, 1);
            yr = zeros(numSteps, 1);
            yl = zeros(numSteps, 1);
            for i=1:length(t)
                dx = evalSpline(this.dCoeffMatX, this.Time, t(i));
                dy = evalSpline(this.dCoeffMatY, this.Time, t(i));
                
                if i==1
                    x(i, 1) = evalSpline(this.CoeffMatX, this.Time, t(i));
                    y(i, 1) = evalSpline(this.CoeffMatY, this.Time, t(i));
                else
                    x(i, 1) = x(i-1)+this.DeltaT*dx;
                    y(i, 1) = y(i-1)+this.DeltaT*dy;
                end
                
                
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
        function [x, y] = filterPoints(this, ox, oy, minDist)
            x = ox(1);
            y = oy(1);
            
            for i=2:length(ox)
                if sqrt((ox(i)-x(end))^2+(oy(i)-y(end))^2)>minDist % Abstand gr��er als Mindestabstand => �bernehme Koordinate
                    x = [x, ox(i)];
                    y = [y, oy(i)];
                end
            end
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
        function [x, y] = getRandomPoints(this, n, dist, width)
            x = zeros(n, 1);
            y = zeros(n, 1);
            for i=1:n/2  % B�ume rechts der Stra�e
                t = rand()*this.Time(end); % Zuf�lliger Zeitpunkt
                
                tx = evalSpline(this.CoeffMatX, this.Time, t);  % Position auf der Stra�e
                ty = evalSpline(this.CoeffMatY, this.Time, t);
                
                dx = evalSpline(this.dCoeffMatX, this.Time, t);  % Ableitung an der Stelle
                dy = evalSpline(this.dCoeffMatY, this.Time, t);
                
                %Berechne rechten Rand
                xy = [0;0];
                xy(1, 1) = dy;
                xy(2, 1) = -dx;
                xy = xy/norm(xy);
                
                x(i) = tx+xy(1, 1)*(dist+rand()*width/2);
                y(i) = ty+xy(2, 1)*(dist+rand()*width/2);
            end
            for i=(n/2+1):n % B�ume links der Stra�e
                t = rand()*this.Time(end); % Zuf�lliger Zeitpunkt
                
                tx = evalSpline(this.CoeffMatX, this.Time, t);  % Position auf der Stra�e
                ty = evalSpline(this.CoeffMatY, this.Time, t);
                
                dx = evalSpline(this.dCoeffMatX, this.Time, t);  % Ableitung an der Stelle
                dy = evalSpline(this.dCoeffMatY, this.Time, t);
                
                %Berechne linken Rand
                xy = [0;0];
                xy(1, 1) = -dy;
                xy(2, 1) = dx;
                xy = xy/norm(xy);
                
                x(i) = tx+xy(1, 1)*(dist+rand()*width/2);
                y(i) = ty+xy(2, 1)*(dist+rand()*width/2);
            end
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
