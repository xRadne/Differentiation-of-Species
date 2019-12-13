%% DIFFERENTIATION OF SPECIES
% Simulation of Complex Systems
% Ellen Sand, Julia Wennerblom, Luc?a Castells Tiestos, Alexander Radne

%% RESET THE PROGRAM BY RUNNING THIS SECTION
% PARAMETERS

clear;
nGenes = 2;
initialPopulationSize = 1000; 
gridSize = 100;
nFood = 10;
distanceParameter = 0.05;
matingProbability = 0.5; % set to reasonable value
mutationProbability=0.2; % set to reasonable value
mutationParameter=0.05; % set to reasonable value
matingDistance=10; % step size in walk function??
sightParameter=10;
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
radius = sightParameter * ones(1,initialPopulationSize);
speed = rand(1,initialPopulationSize);
foodX = rand(1,nFood) * gridSize;
foodY = rand(1,nFood) * gridSize;

%% MAIN LOOP
% Stop the program by selecting the command window and press: 'Ctrl + C'
nAgents=initialPopulationSize;
figure(1)
while nAgents>0
    fprintf('Time: %1i\n', time+1)
    speed = rand(1,length(agentX));
    [agentX,agentY] = Walk(agentX,agentY,speed,radius,foodX,foodY,gridSize); 
    agentChromosome = Mutate(agentX,mutationProbability,mutationParameter,agentChromosome,mMin,mMax);
    [agentAge,agentX,agentY,agentChromosome] = Age(agentX,agentY,agentChromosome,agentAge,maxLife);
    [agentAge,agentX,agentY,agentChromosome,radius] = Mate(agentChromosome,agentAge,agentX,agentY,radius,matingDistance,geneticDistance,distanceParameter,matingProbability,sightParameter,gridSize);    %population = Mutate(population,mutationProbability,mutationParameter,nGenes,mMin,mMax);
 
    pause(0.3);
    plot(agentX,agentY,'or');
    drawnow
    time = time + 1; % Timestep done
    nAgents=size(agentX,2);
end

%% DISPLAY DATA
figure(1); clf;
species = ComputeComponents(agentChromosome,distanceParameter);
PlotGenomeClusters2D(agentChromosome(1,:),agentChromosome(2,:),species);
