x = [0, 2, 3, 1, 3, 1.5, 0];
y = [0, 2, 1, -1, -1.5, 0.5, 2];
sen = Sensor(x,y);    
sen.plotRouteStationaer(10000,0.4);
sen.fahrenlassen();