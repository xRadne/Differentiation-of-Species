%% DIFFERENTIATION OF SPECIES
% Simulation of Complex Systems
% Ellen Sand, Julia Wennerblom, Luc?a Castells Tiestos, Alexander Radne

%% RESET THE PROGRAM BY RUNNING THIS SECTION
% PARAMETERS

clear;
nGenes = 2;
initialPopulationSize = 100; 
gridSize = 100;
nFood = 20;
maxFood = 1;
biteSize = 0.1;
foodRegenerateAmount = 0.01;

lowerX = 40;
midX = 50;
higherX = 75;
lowerY = 30;
higherY = 68;
nFood = 10;
foodRadius = 5;
foodEdabilityRange = 0.2;
distanceParameter = 0.05;
matingProbability = 0.5; % set to reasonable value
mutationProbability=0.2; % set to reasonable value
mutationParameter=0.05; % set to reasonable value
matingDistance=10; % step size in walk function??
sightParameter=10;
mMin=0.0001; % set to reasonable value
mMax=0.9999; % set to reasonable value
maxLife=100;
deathParameter=0.001;
hungerParameter=0.01;
maxHunger=10;

% INITIALIZE POPULATION
time = 0;
agentX=randi([0, gridSize],1,initialPopulationSize); 
agentY=randi([0, gridSize],1,initialPopulationSize);
agentChromosome=rand(nGenes,initialPopulationSize); 
agentAge=zeros(1,initialPopulationSize);
agentHunger=ones(1,initialPopulationSize);
geneticDistance = GeneticDistance(agentChromosome); 
sightRadius = sightParameter * ones(1,initialPopulationSize);
speed=(1-agentChromosome(1,:))*2;
nAgents=initialPopulationSize;
geneticDistanceParameter = distanceParameter;

% INITIALIZE FOOD
foodX = rand(1,nFood) * gridSize;
foodY = rand(1,nFood) * gridSize;
foodAmount = rand(1,nFood) * maxFood;
foodType = rand(1,nFood);

%% MAIN LOOP
% Stop the program by selecting the command window and press: 'Ctrl + C'
figure(1)

while nAgents>0
    fprintf('Time: %1i\n', time+1)

    [agentHunger,foodAmount,foodX,foodY,iClosestFood,squaredDistanceClosestFood] = Eat(agentX,agentY,agentHunger,foodX,foodY,foodAmount,foodRadius,foodType,foodEdabilityRange,biteSize,agentChromosome,gridSize);
    foodAmount(foodAmount<maxFood) = foodAmount(foodAmount<maxFood) + foodRegenerateAmount;

    % [agentX,agentY] = Walk(agentX,agentY,speed,radius,foodX,foodY,foodAmount,gridSize); 
    [agentAge,agentX,agentY,agentChromosome,agentHunger] = Age(agentX,agentY,agentChromosome,agentAge,maxLife,deathParameter,agentHunger,hungerParameter,maxHunger);
    [agentAge,agentX,agentY,agentChromosome,sightRadius] = Mate(agentChromosome,agentAge,agentX,agentY,sightRadius,foodX,foodY,foodRadius,matingDistance,geneticDistance,distanceParameter,matingProbability,sightParameter,gridSize,mutationProbability,mutationParameter,mMin,mMax);
%     geneticDistance = GeneticDistance(agentChromosome); 
    speed=(1-agentChromosome(1,:))*2;
    
    iClosestEligableMate = ClosestEligableMate(agentX,agentY,agentChromosome,geneticDistanceParameter);
    [agentX,agentY] = ValleyWalk(agentX,agentY,speed,sightRadius,foodX,foodY,foodAmount,agentHunger,maxHunger,gridSize,lowerX,midX,higherX,lowerY,higherY,iClosestFood,squaredDistanceClosestFood,iClosestEligableMate,10,0.5);
    
    PlotEnvironment(agentX,agentY,foodX(foodAmount>biteSize),foodY(foodAmount>biteSize),agentChromosome,foodAmount(foodAmount>biteSize),lowerX,midX,higherX,lowerY,higherY);
    nAgents=size(agentX,2);
    time = time + 1; % Timestep done
   

    
end

%% DISPLAY DATA
figure(1); clf;
species = ComputeComponents(agentChromosome,distanceParameter);
PlotGenomeClusters2D(agentChromosome(1,:),agentChromosome(2,:),species);
