function [agentHunger,foodAmount] = Eat(agentX,agentY,agentHunger,foodX,foodY,foodAmount,foodRadius, biteSize,agentChromosome)
    % biteSize is how much food an agent eats each time step
    
    squaredDistanceMatrix = (agentX-foodX').^2 + (agentY-foodY').^2;
    [squaredDistanceClosestFood, iClostestFood] = min(squaredDistanceMatrix);

    foodWithinRange = squaredDistanceClosestFood < foodRadius^2;
    foodLeft = foodAmount >= biteSize;
    agentsEating = foodWithinRange & foodLeft(iClostestFood);

    %size difference
    agentSize=agentChromosome(1,:);
    occurrences=sum(iClostestFood(agentsEating)==iClostestFood(agentsEating)');
    
    eatingIdx=find(agentsEating==1);
    soloEaters=eatingIdx((occurrences==1));
    groupEaters=eatingIdx(occurrences>1);
    foodRatio=[];
    for i=1:length(groupEaters)
       toFight=find(iClostestFood(groupEaters(i))==iClostestFood(groupEaters));
       foodRatio(i)=agentSize(groupEaters(i))./sum(agentSize(groupEaters(toFight))); 
    end
    
    agentHunger(soloEaters)=agentHunger(soloEaters) + biteSize;
  
    agentHunger(groupEaters)=agentHunger(groupEaters)+foodLeft(iClostestFood(groupEaters)).*foodRatio;
   
    %agentHunger(agentsEating) = agentHunger(agentsEating) + biteSize;
    %foodAmount(iClostestFood(agentsEating)) = foodAmount(iClostestFood(agentsEating)) - biteSize;
    foodAmount(iClostestFood(soloEaters)) = foodAmount(iClostestFood(soloEaters)) - biteSize;
    foodAmount(iClostestFood(groupEaters)) = foodAmount(iClostestFood(groupEaters)) - foodLeft(iClostestFood(groupEaters)).*foodRatio;
end