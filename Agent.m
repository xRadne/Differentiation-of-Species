classdef Agent
    %AGENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x
        y
        chromosome
        age=0;
    end
    
    methods
        function obj = Agent(chromosome, gridSize)
            %AGENT Construct an instance of this class
            %   Detailed explanation goes here
            obj.x = ceil(rand() * gridSize);
            obj.y = ceil(rand() * gridSize);
            obj.chromosome = chromosome;
        end
    end
end
