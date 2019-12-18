function [newAgentX,newAgentY] = WhyNotWorking(agentX,agentY,speed,radius,foodX,foodY,foodAmount,hungerParameter,maxHunger,gridSize,iClosestFood,squaredDistanceClosestFood,iClosestEligableMate,goingRadius,mateRadius,biteSize)
    
    nAgents = length(agentY);
    newAgentX = zeros(1,nAgents);
    newAgentY = zeros(1,nAgents);
    foodAgentX = foodX - agentX';
    foodAgentY = foodY - agentY';
    %distanceSquared = (foodAgentX).^2 + (foodAgentY).^2;
    %[distance,index] = min(distanceSquared,[],2);
    index = iClosestFood;
    distance = squaredDistanceClosestFood;
    speedAux = speed;
    % logicalHungerParameter = hungerParameter >= maxHunger;
    % speed(speed.^2 > distance) = sqrt(distance);
    
    for idx = 1:length(speed)
        R = radius(idx);
        if (speed(idx)*speed(idx) > distance(idx)) & (foodAmount(index(idx))>=0.1) & (distance(idx) < R^2) & (hungerParameter(idx) < 0.5*maxHunger)
            speed(idx) = sqrt(distance(idx)) - 0.1; 
        end
    end

    for idx = 1:length(agentY)
        posX = agentX(idx);
        posY = agentY(idx);
        R = radius(idx);
        if iClosestEligableMate(idx) == 0
            distanceClosestAgent = inf;
        else
            distanceClosestAgent = (agentX(idx) - agentX(iClosestEligableMate(idx)))^2 + (agentY(idx) - agentY(iClosestEligableMate(idx)))^2;
        end
        if (distance(idx) < R^2) & foodAmount(index(idx))>=biteSize & (hungerParameter(idx) <= 0.5*maxHunger)
            if (foodAgentX(idx,index(idx)) > 0)
                theta = atan(foodAgentY(idx,index(idx))/foodAgentX(idx,index(idx)));
                posX = posX + speed(idx)*cos(theta);
                posY = posY + speed(idx)*sin(theta);
            else
                theta = pi + atan(foodAgentY(idx,index(idx))/foodAgentX(idx,index(idx)));
                posX = posX + speed(idx)*cos(theta);
                posY = posY + speed(idx)*sin(theta);
            end
        elseif (distanceClosestAgent < goingRadius^2) & (hungerParameter(idx) > 0.5*maxHunger)
            if distanceClosestAgent > mateRadius^2
                if (speed(idx)+speed(iClosestEligableMate(idx))) > sqrt(distanceClosestAgent)
                    speed(idx) = sqrt(distanceClosestAgent)/2 - 0.05;
                    speed(iClosestEligableMate(idx)) = sqrt(distanceClosestAgent)/2 - 0.05;
                end
                if (agentX(iClosestEligableMate(idx))-agentX(idx)) > 0
                    theta = atan((agentY(iClosestEligableMate(idx))-agentY(idx))/(agentX(iClosestEligableMate(idx))-agentX(idx)));
                else
                    theta = pi + atan((agentY(iClosestEligableMate(idx))-agentY(idx))/(agentX(iClosestEligableMate(idx))-agentX(idx)));
                end
                posX = posX + speed(idx)*cos(theta);
                posY = posY + speed(idx)*sin(theta);
                speed(idx) = speedAux(idx);
            end
        else
            theta = rand*2*pi;
            posX = posX + speedAux(idx)*cos(theta);
            posY = posY + speedAux(idx)*sin(theta);
        end
        if (posX > gridSize)
            posX = posX - gridSize;
        elseif (posX < 0)
            posX = posX + gridSize;
        end
        if (posY > gridSize)
            posY = posY - gridSize;
        elseif (posY < 0)
            posY = posY + gridSize;
        end
        newAgentX(idx) = posX;
        newAgentY(idx) = posY;
    end
    
    for idx = 1:length(newAgentY)
        for idx2 = 1:length(foodY)
            rx = foodX(idx2) - newAgentX(idx);
            ry = foodY(idx2) - newAgentY(idx);
            distance = sqrt(rx*rx + ry*ry);
            if (distance < 0.1)
                overlap = 0.1 - distance;
                newAgentX(idx) = newAgentX(idx) - overlap*(rx/distance);
                newAgentY(idx) = newAgentY(idx) - overlap*(ry/distance);
            end
        end
    end
    
end