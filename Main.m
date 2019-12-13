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
maxLife=5;

% INITIALIZE POPULATION
time = 0;
agentX=randi([0, gridSize],1,initialPopulationSize); % is the grid 0 to 100?
agentY=randi([0, gridSize],1,initialPopulationSize);
agentChromosome=rand(nGenes,initialPopulationSize); 
agentAge=zeros(1,initialPopulationSize);
geneticDistance = GeneticDistance(agentChromosome); 
radius = rand(1,100) * 3;
speed = rand(1,100);
foodX = rand(1,10) * gridSize;
foodY = rand(1,10) * gridSize;

%% MAIN LOOP
% Stop the program by selecting the command window and press: 'Ctrl + C'
figure(1)
while true
    fprintf('Time: %1i\n', time+1)
    [agentX,agentY] = Walk(agentX,agentY,speed,radius,foodX,foodY,gridSize); 
    agentChromosome = Mutate(agentX,mutationProbability,mutationParameter,agentChromosome,mMin,mMax);
    [agentAge,agentX,agentY,agentChromosome] = Age(agentX,agentY,agentChromosome,agentAge,maxLife);
    
    plot(agentX,agentY,'or');
    time = time + 1; % Timestep done
end

%% DISPLAY DATA
figure(1); clf;
species = ComputeComponents(agentChromosome,distanceParameter);
PlotGenomeClusters2D(agentChromosome(1,:),agentChromosome(2,:),species);
