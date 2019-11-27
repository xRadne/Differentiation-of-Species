%% DIFFERENTIATION OF SPECIES
% Simulation of Complex Systems
% Ellen Sand, Julia Wennerblom, Lucía Castells Tiestos, Alexander Radne

%% RESET THE PROGRAM BY RUNNING THIS SECTION
% PARAMETERS
clear;
nGenes = 1;
populationSize = 100;
gridSize = 100;
distanceParameter = 0.2;
matingProbability = 0.5; % set to reasonable value
mutationProbability=0.02; % set to reasonable value
mutationParameter=0.05; % set to reasonable value
mMin=0.0001; % set to reasonable value
mMax=0.9999; % set to reasonable value

% INITIALIZE POPULATION
time = 0;
population = InitializePopulation(nGenes, populationSize);
geneticDistance = GeneticDistance(population,nGenes); 


%% MAIN LOOP
% Stop the program by pressing: 'Ctrl + C'
while true
    fprintf('Time: %1i\n', time+1)
    population = Walk(population);
    population = Mate(population, geneticDistance, distanceParameter);
    population = Mutate(population,mutationProbability,mutationParameter,nGenes,mMin,mMax);
    geneticDistance = GeneticDistance(population,nGenes);
    statistics = Evaluate(population,nGenes);
    
    time = time + 1; % Timestep done
end

%% DISPLAY DATA
% 
K = 2;
genomes = zeros(populationSize, nGenes);
for i = 1:populationSize
    genomes(i,:) = population(i).chromosome;
end
PlotGenomeClusters2D(genomes, genomes, K);
