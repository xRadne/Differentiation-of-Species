%% DIFFERENTIATION OF SPECIES
% Simulation of Complex Systems
% Ellen Sand, Julia Wennerblom, Lucía Castells Tiestos, Alexander Radne

%% RESET THE PROGRAM BY RUNNING THIS SECTION
% PARAMETERS
nGenes = 1;
populationSize = 100;
gridSize = 100;
distanceParameter = 0.2;

% INITIALIZE POPULATION
time = 0;
population = InitializePopulation(nGenes, populationSize);
geneticDistance = GeneticDistance(population); 

%% MAIN LOOP
% Stop the program by pressing: 'Ctrl + C'
while true
    fprintf('Time: %1i\n', time+1)
    population = Walk(population);
    population = Mate(population, geneticDistance, distanceParameter);
    population = Mutate(population);
    geneticDistance = GeneticDistance(population);
    statistics = Evaluate(population);
    
    time = time + 1; % Timestep done
end



