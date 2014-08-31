classdef Continuous_2D_world < handle
    %CONTINUOUS_2D_WORLD
    % no action, the agent just teleport for now
    
    properties
        
        minPosition = 0
        maxPosition = 1
        
        position = [0.5, 0.5]
        
    end
    
    methods
        
        function self = Continuous_2D_world()
            
        end
        
        function set_position(self, position)
            if any(position < self.minPosition) && any(position > self.maxPosition)
                error('continuous_2D_world:set_position:PositionNonValid', 'This position is not valid.')
            end
            self.position = position;
        end
        
        function position = get_position(self)
            position = self.position;
        end
        
        function positionSamples = sample_positions(~, nSamples)
            positionSamples = rand(nSamples, 2);
        end
        
    end
    
end

