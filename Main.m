%% DIFFERENTIATION OF SPECIES
% Simulation of Complex Systems
% Ellen Sand, Julia Wennerblom, Luc?a Castells Tiestos, Alexander Radne

%% RESET THE PROGRAM BY RUNNING THIS SECTION
% PARAMETERS

clear;
nGenes = 2;
initialPopulationSize = 100; 
gridSize = 100;
distanceParameter = 0.05;
matingProbability = 0.5; % set to reasonable value
mutationProbability=0.2; % set to reasonable value
mutationParameter=0.05; % set to reasonable value
mMin=0.0001; % set to reasonable value
mMax=0.9999; % set to reasonable value
tDeath=5; 

% INITIALIZE POPULATION
time = 0;
population = InitializePopulation(nGenes, initialPopulationSize);
geneticDistance = GeneticDistance(population,nGenes); 


%% MAIN LOOP
% Stop the program by selecting the command window and press: 'Ctrl + C'
while true
    fprintf('Time: %1i\n', time+1)
    population = Walk(population);
    population = Die(population, length(population)/10000);
    population = Mate(population, geneticDistance, distanceParameter,matingProbability,nGenes);
    population = Mutate(population,mutationProbability,mutationParameter,nGenes,mMin,mMax);
    population = Age(population,tDeath);
    geneticDistance = GeneticDistance(population,nGenes);
    statistics = Evaluate(population,nGenes);
    
    time = time + 1; % Timestep done
end

%% DISPLAY DATA
K = 1;
genomes = zeros(length(population), nGenes);
for i = 1:length(population)
    genomes(i,:) = population(i).chromosome;
end
PlotGenomeClusters2D(genomes(:,1), genomes(:,2), K);
axis([0 1 0 1]);
xlabel('Gene 1')
ylabel('Gene 2')