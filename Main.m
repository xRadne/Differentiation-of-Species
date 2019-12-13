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
matingDistance=0.01; % step size in walk function??
mMin=0.0001; % set to reasonable value
mMax=0.9999; % set to reasonable value
maxLife=5;

% INITIALIZE POPULATION
time = 0;
agentX=randi([0, gridSize],1,initialPopulationSize); % is the grid 0 to 100?
agentY=randi([0, gridSize],1,initialPopulationSize);
agentChromosome=rand(nGenes,initialPopulationSize); 
agentAge=zeros(1,initialPopulationSize);
population=ones(1,initialPopulationSize);
geneticDistance = GeneticDistance(agentChromosome); 


%% MAIN LOOP
% Stop the program by selecting the command window and press: 'Ctrl + C'
while true
    fprintf('Time: %1i\n', time+1)
    %population = Walk(population); 
    population = Die(population, length(population)/10000);
    [agentAge,agentX,agentY,agentChromosome] = Mate(agentChromosome,agentAge,agentX,agentY,matingDistance,geneticDistance,distanceParameter,matingProbability);    %population = Mutate(population,mutationProbability,mutationParameter,nGenes,mMin,mMax);
    %population = Age(population,maxLife);
    %geneticDistance = GeneticDistance(population,nGenes);
    %statistics = Evaluate(population,nGenes);
    
    time = time + 1; % Timestep done
end

%% DISPLAY DATA
K = 3;
genomes = zeros(length(population), nGenes);
for i = 1:length(population)
    genomes(i,:) = population(i).chromosome;
end
PlotGenomeClusters2D(genomes(:,1), genomes(:,2), K);
