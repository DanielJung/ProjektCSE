classdef Car
    properties
        timer
        sensor1
        sensor2
    end
    
    methods
        function this=Car(dt)
            this.timer = Timer();
            this.sensor1 = Sensor1();
            this.sensor2 = Sensor2();
        end
        function this=onFrame(this)
        end
    end
    
end

