%% DIFFERENTIATION OF SPECIES
% Simulation of Complex Systems
% Ellen Sand, Julia Wennerblom, Luc?a Castells Tiestos, Alexander Radne

%% RESET THE PROGRAM BY RUNNING THIS SECTION
% PARAMETERS
% all agents collect around borders 
clear;
nGenes = 2;
initialPopulationSize = 100; 
gridSize = 100;

maxFood = 1;
biteSize = 0.1;
foodRegenerateAmount = 0.01;

lowerX = 40;
midX = 50;
higherX = 75;
lowerY = 30;
higherY = 68;
nFood = 20;
foodEdabilityRange = 0.2;
distanceParameter = 0.1;
matingProbability = 0.9; % set to reasonable value
mutationProbability=0.8; % set to reasonable value
mutationParameter=0.5; % set to reasonable value
matingDistance=0.8; % step size in walk function??
sightParameter=9;
mMin=0.0001; % set to reasonable value
mMax=0.9999; % set to reasonable value
maxLife=15;
deathParameter=0.06;
hungerParameter=0.01;
maxHunger=5;

% INITIALIZE POPULATION
time = 0;
agentX=randi([0, gridSize],1,initialPopulationSize); % is the grid 0 to 100?
agentY=randi([0, gridSize],1,initialPopulationSize);
agentChromosome=rand(nGenes,initialPopulationSize); 
agentAge=zeros(1,initialPopulationSize);
agentHunger=ones(1,initialPopulationSize);
geneticDistance = GeneticDistance(agentChromosome); 
radius = sightParameter * ones(1,initialPopulationSize);
speed = rand(1,initialPopulationSize);
nAgents=initialPopulationSize;

% INITIALIZE FOOD
foodX = rand(1,nFood) * gridSize;
foodY = rand(1,nFood) * gridSize;
foodAmount = rand(1,nFood) * maxFood;
foodRadius = 1;

%% MAIN LOOP
% Stop the program by selecting the command window and press: 'Ctrl + C'
figure(1)
while nAgents>0
    fprintf('Time: %1i\n', time+1)
 
    foodAmount(foodAmount<maxFood) = foodAmount(foodAmount<maxFood) + foodRegenerateAmount;

    [agentAge,agentX,agentY,agentChromosome,agentHunger] = Age(agentX,agentY,agentChromosome,agentAge,maxLife,deathParameter,agentHunger,hungerParameter,maxHunger);  
    [agentAge,agentX,agentY,agentChromosome,sightRadius,agentHunger] = Mate(agentChromosome,agentAge,agentX,agentY,sightRadius,foodX,foodY,foodRadius,matingDistance,geneticDistance,distanceParameter,matingProbability,sightParameter,gridSize,mutationProbability,mutationParameter,mMin,mMax,agentHunger,maxHunger);
    geneticDistance = GeneticDistance(agentChromosome); 
    [agentHunger,foodAmount,foodX,foodY,iClosestFood,squaredDistanceClosestFood] = Eat(agentX,agentY,agentHunger,foodX,foodY,foodAmount,foodRadius,foodType,foodEdabilityRange,biteSize,agentChromosome,gridSize);
    
    speed=(1-agentChromosome(1,:))*2;
    
    iClosestEligableMate = ClosestEligableMate(agentX,agentY,agentChromosome,geneticDistanceParameter);
    [agentX,agentY] = ValleyWalk(agentX,agentY,speed,sightRadius,foodX,foodY,foodAmount,agentHunger,maxHunger,gridSize,lowerX,midX,higherX,lowerY,higherY,iClosestFood,squaredDistanceClosestFood,iClosestEligableMate,4,0.5);
    
    PlotEnvironment(agentX,agentY,foodX(foodAmount>biteSize),foodY(foodAmount>biteSize),agentChromosome,foodAmount(foodAmount>biteSize),lowerX,midX,higherX,lowerY,higherY,gridSize);
    nAgents=size(agentX,2);
    time = time + 1; % Timestep done
end

%% DISPLAY DATA
figure(1); clf;
species = ComputeComponents(agentChromosome,distanceParameter);
PlotGenomeClusters2D(agentChromosome(1,:),agentChromosome(2,:),species);
