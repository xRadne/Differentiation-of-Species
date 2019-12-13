function [agentHunger,foodAmount] = Eat(agentX,agentY,agentHunger,foodX,foodY,foodAmount,foodRadius, biteSize)
    % biteSize is how much food an agent eats each time step
    
    squaredDistanceMatrix = (agentX-foodX').^2 + (agentY-foodY').^2;
    [squaredDistanceClosestFood, iClostestFood] = min(squaredDistanceMatrix);

    foodWithinRange = squaredDistanceClosestFood < foodRadius^2;
    foodLeft = foodAmount >= biteSize;
    agentsEating = foodWithinRange & foodLeft(iClostestFood);

    agentHunger(agentsEating) = agentHunger(agentsEating) + biteSize;
    foodAmount(iClostestFood(agentsEating)) = foodAmount(iClostestFood(agentsEating)) - biteSize;

end