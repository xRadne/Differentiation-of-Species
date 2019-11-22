function newPopulation = InitializePopulation(nGenes, populationSize)
%INITIALIZEPOPULATION Summary of this function goes here
%   Detailed explanation goes here
    array = repmat(Agent(0, 0),1, populationSize); % Preallocation
    for i = 1: populationSize
        randomChromosome = rand(1, nGenes);
        array(i) = Agent(randomChromosome, 100);
    end
    newPopulation =  array;
end

