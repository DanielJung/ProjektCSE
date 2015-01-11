classdef Timer
    
    properties
        TimeInt     % Time-Interval to refresh
        NextTime    % Next Time to refresh Sensors
        Sensors     % Sensors to refresh
    end
    
    methods
        function this = Timer(timeint, sensors)
            this.TimeInt = timeint;
            this.NextTime = timeint; % Next Time to refresh is first interval
            this.Sensors = sensors;
        end
        function onUpdate(this, time)
            for i=1:length(this.TimeInt)
                if(this.NextTime(i)<=time)
                    this.NextTime(i) = time+this.TimeInt(i);
                    this.Sensors(i).onUpdate();
                end
            end
        end
    end
    
end

