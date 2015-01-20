classdef varianz
    
    properties (GetAccess=public)
        
    % SMPC (1/sqrt(5))*0.2/0.2*1600)*x^2
    % 5.5/1600*x
    
    
    end

    methods
        
        function [x,y] = getVarSMPC(this,xCenter,yCenter)
          
          xRadius = (1/sqrt(5))*0.2/(0.2*1600)*xCenter^2;
          yRadius = 5.5/1600*xCenter;
          theta = 0 : 0.01 : 2*pi;
          x = xRadius * cos(theta) + xCenter;
          y = yRadius * sin(theta) + yCenter;
          plot(x, y, 'LineWidth', 3);
          axis square;
          grid on;
            
            
            
        end
        
        function [x,y]=getVarSMPCLR(this,xCenter,yCenter)
            
            xRadius = (1/sqrt(10))*0.2/(0.2*1600)*xCenter^2;
            yRadius = 0.00125*xCenter;
            theta = 0 : 0.01 : 2*pi;
            x = xRadius * cos(theta) + xCenter;
            y = yRadius * sin(theta) + yCenter;
            plot(x, y, 'LineWidth', 3);
            axis square;
            grid on;
        end
        
        function h = draw_ellipse(x, c, outline_color, fill_color)
% DRAW_ELLIPSE(x, c, outline_color, fill_color)
%   Draws ellipses at centers x with covariance matrix c.
%   x is a matrix of columns.  c is a positive definite matrix.
%   outline_color and fill_color are optional.

n = 2000;					% resolution
radians = [0:(2*pi)/(n-1):2*pi];
unitC = [sin(radians); cos(radians)];
r = chol(c)';

if nargin < 3
  outline_color = 'g';
end

h = [];
for i=1:size(x,2)
  y = r*unitC + repmat(x(:, i), 1, n);
  if nargin < 4
    h = [h line(y(1,:), y(2,:), 'Color', outline_color,'linewidth',2)];
  else
    h = [h fill(y(1,:), y(2,:), fill_color, 'EdgeColor', outline_color)];
  end
end
           
            
            
            
        
        
        function [x,y]=getVarianzRadar(this,r,phi)
            theta = 0:0.01:2*pi;
            
        end
        
        function[x,y]=getVarLidar(this,r,phi)
            
        end
end