function [agentHunger,foodAmount,foodX,foodY,iClosestFood,squaredDistanceClosestFood] = Eat(agentX,agentY,agentHunger,foodX,foodY,foodAmount,foodRadius,foodType,foodEdabilityRange,biteSize,agentChromosome,gridSize)
    % biteSize is how much food an agent eats each time step
    
    agentPreference = agentChromosome(2,:);
    
    squaredDistanceMatrix = (agentX-foodX').^2 + (agentY-foodY').^2;
    edibleMatrix = abs(foodType'-agentPreference)< foodEdabilityRange;
    squaredDistanceMatrix(not(edibleMatrix))=inf;
    [squaredDistanceClosestFood, iClosestFood] = min(squaredDistanceMatrix);

    
    foodWithinRange = squaredDistanceClosestFood < foodRadius^2;
    foodLeft = foodAmount >= biteSize;
    %edibleByAgent = abs(foodType(iClosestFood)-agentPreference) < foodEdabilityRange;
    agentsEating = foodWithinRange & foodLeft(iClosestFood); %& edibleByAgent;
   
    %size difference
    agentSize=agentChromosome(1,:);
    occurrences=sum(iClosestFood(agentsEating)==iClosestFood(agentsEating)');
    
    eatingIdx=find(agentsEating==1);
    soloEaters=eatingIdx(occurrences==1);
    groupEaters=eatingIdx(occurrences>1);
    foodRatio=zeros(1,length(groupEaters));
    for i=1:length(groupEaters)
       toFight=iClosestFood(groupEaters(i))==iClosestFood(groupEaters);
       foodRatio(i)=agentSize(groupEaters(i))./sum(agentSize(groupEaters(toFight))); 
    end
    
    agentHunger(soloEaters)=agentHunger(soloEaters) + biteSize;
  
    agentHunger(groupEaters)=agentHunger(groupEaters) + biteSize.*foodRatio;
   
    foodAmount(iClosestFood(soloEaters)) = foodAmount(iClosestFood(soloEaters)) - biteSize;
    foodAmount(iClosestFood(groupEaters)) = foodAmount(iClosestFood(groupEaters)) - foodLeft(iClosestFood(groupEaters)).*foodRatio;

    % MOVE EMPTY FOOD RESOURCES
    foodX(~foodLeft) = gridSize * rand(1, sum(~foodLeft));
    foodY(~foodLeft) = gridSize * rand(1, sum(~foodLeft));
end