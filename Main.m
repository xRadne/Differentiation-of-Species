%% DIFFERENTIATION OF SPECIES
% Simulation of Complex Systems
% Ellen Sand, Julia Wennerblom, Luc?a Castells Tiestos, Alexander Radne

%% RESET THE PROGRAM BY RUNNING THIS SECTION
% PARAMETERS

clear;
nGenes = 2;
initialPopulationSize = 10; 
gridSize = 100;
maxFood = 1;
biteSize = 0.1;
foodRegenerateAmount = 0.01;

lowerX = 40/100*gridSize;
midX = 50/100*gridSize;
higherX = 75/100*gridSize;
lowerY = 30/100*gridSize;
higherY = 68/100*gridSize;
nFood = 100;
foodRadius = 5;
foodEdabilityRange = 0.3;
distanceParameter = 0.3;
matingProbability = 1.0; % set to reasonable value
mutationProbability=0.2; % set to reasonable value
mutationParameter=0.05; % set to reasonable value
matingDistance=0.5; % step size in walk function??
sightParameter=50;
mMin=0.0001; % set to reasonable value
mMax=0.9999; % set to reasonable value
maxLife=100;
deathParameter=0.001;
hungerParameter=0.01;
maxHunger=10;
goingRadius = sightParameter;
mateRadius = matingDistance;

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
valleyX = gridSize/2;
valleyY = gridSize/2;

%% MAIN LOOP
% Stop the program by selecting the command window and press: 'Ctrl + C'
fig=figure(1);
while nAgents>0
    fprintf('Time: %1i, N: %3i\n', time+1,nAgents)

    foodAmount(foodAmount<maxFood) = foodAmount(foodAmount<maxFood) + foodRegenerateAmount;
    foodType = sqrt((foodX-valleyX).^2 + (foodY-valleyY).^2) / (sqrt(2)*gridSize/2);
    
    [agentAge,agentX,agentY,agentChromosome,agentHunger] = Age(agentX,agentY,agentChromosome,agentAge,maxLife,deathParameter,agentHunger,hungerParameter,maxHunger);
    [agentAge,agentX,agentY,agentChromosome,sightRadius,agentHunger] = Mate(agentChromosome,agentAge,agentX,agentY,sightRadius,foodX,foodY,foodRadius,matingDistance,geneticDistance,distanceParameter,matingProbability,sightParameter,gridSize,mutationProbability,mutationParameter,mMin,mMax,maxHunger,agentHunger);
    [agentHunger,foodAmount,foodX,foodY,iClosestFood,squaredDistanceClosestFood] = Eat(agentX,agentY,agentHunger,foodX,foodY,foodAmount,foodRadius,foodType,foodEdabilityRange,biteSize,agentChromosome,gridSize);
 
    geneticDistance = GeneticDistance(agentChromosome); 
    speed=(1-agentChromosome(1,:))*2;
    
    iClosestEligableMate = ClosestEligableMate(agentX,agentY,agentChromosome,geneticDistanceParameter);
    [agentX,agentY] = ValleyWalk(agentX,agentY,speed,sightRadius,foodX,foodY,foodAmount,agentHunger,maxHunger,gridSize,lowerX,midX,higherX,lowerY,higherY,iClosestFood,squaredDistanceClosestFood,iClosestEligableMate,goingRadius,mateRadius,biteSize);
    
    PlotEnvironment(agentX,agentY,foodX(foodAmount>biteSize),foodY(foodAmount>biteSize),agentChromosome,foodAmount(foodAmount>biteSize),lowerX,midX,higherX,lowerY,higherY,gridSize,foodType(foodAmount>biteSize));
    nAgents=size(agentX,2);
    
    time = time + 1; % Timestep done
    frames(time) = getframe(fig);
end

%% SAVE VIDEO
writerObj = VideoWriter('Video.avi');
writerObj.FrameRate = 10;
open(writerObj);

for i=1:length(frames)
    frame = frames(i) ;    
    writeVideo(writerObj, frame);
end
close(writerObj);

%% SAVE GIF
filename = sprintf('Test.gif');
open(writerObj);
for i=1:length(frames)
    frame = frames(i);
    im = frame2im(frame);
    [imind1,cm]=rgb2ind(im,256);
    
    writeVideo(writerObj, frame);
    if i==1
        imwrite(imind1,cm,filename,'gif','Loopcount',inf);
    else
        imwrite(imind1,cm,filename,'gif','WriteMode','append');
    end
end
close(writerObj);

%% DISPLAY DATA
figure(1); clf;
species = ComputeComponents(agentChromosome,distanceParameter);
PlotGenomeClusters2D(agentChromosome(1,:),agentChromosome(2,:),species);
