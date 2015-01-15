classdef Car
    properties
        timer       % Timer für die Sensoren
        street      % Referenz auf die Straße
        time        % Aktuelle Simulationszeit
        curSpeed    % Aktuelle Geschwindigkeit
        speed       % Geschwindigkeitsmatrix
        speedid     % Aktuelle ID in der Matrix
    end
    
    methods
        function this=Car(rstreet, speed_file)
            this.timer = Timer();
            this.street = rstreet;
            this.time = 0;
            this.curSpeed = 0;
            this.speed = load(speed_file);
            this.speedid = 1;
        end
        function this=onFrame(this)
            this.street = this.street.step(this.curSpeed);
            this.timer.onUpdate(this.time);
            [m, n] = size(this.speed);
            if(this.speedid<m)
                if(this.speed(this.speedid+1, 1)>this.time) % Nächste Geschwindigkeit wird angenommen
                    this.speedid = this.speedid+1;
                    this.curSpeed = this.speed(this.speedid, 2);
                end
            end
        end
        function [s] = getStreet(this)
            s = this.street;
        end
        function [x] = getPosition2D(this)
            x = this.street.getPosition2D();
        end
        function [x] = getPosition3D(this)
            x = this.street.getPosition3D();
        end
        function [r] = getRotation(this)
            r = this.street.getRotation();
        end
        function [t] = getTime(this)
            t = this.time;
        end
        function [r] = getWheelRotation(this)
            r = this.street.getWheelRotation();
        end
        function [v] = getSpeed(this)
            v = this.curSpeed;
        end
    end
    
end

