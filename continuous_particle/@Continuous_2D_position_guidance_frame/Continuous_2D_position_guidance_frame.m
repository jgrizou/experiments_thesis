classdef Continuous_2D_position_guidance_frame < handle
    %OBJECTDIRECTIONABSOLUTE
    
    properties
        errorRate = 0;
        labelsNames = {'up', 'down', 'right', 'left'}
        labelsTheta = [pi/2, -pi/2, 0, pi]
    end
    
    methods
        
        function self = Continuous_2D_position_guidance_frame(errorRate)
            % The error rate model the error rate (default is 0)
            if nargin > 0
                self.errorRate = errorRate;
            end
        end
        
        function labels = compute_labels(self, goalPosition, agentPosition)
            
            if goalPosition == agentPosition
                labels = proba_normalize_row(ones(1,length(self.labelsNames)));
                return
            end
            
            U = goalPosition(1) - agentPosition(1);
            V = goalPosition(2) - agentPosition(2);
            theta = atan2(V, U);
            
            labels = zeros(1, length(self.labelsTheta));
            if ~isnan(theta)
                diffTheta = mod(theta - self.labelsTheta, 2*pi);
                diffTheta(diffTheta > pi) = diffTheta(diffTheta > pi) - 2*pi;
                labels = 1 - abs(diffTheta)/(pi/2);
                labels(labels < 0) = 0;
            end
            labels = apply_noise(labels, self.errorRate);
        end
    end
end