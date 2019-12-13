function [newAgentX,newAgentY] = Walk(agentX,agentY,speed,radius,foodX,foodY,gridSize)
    
    nAgents = length(agentY);
    newAgentX = zeros(1,nAgents);
    newAgentY = zeros(1,nAgents);
    foodAgentX = foodX - agentX';
    foodAgentY = foodY - agentY';
    distanceSquared = (foodAgentX).^2 + (foodAgentY).^2
    [distance,index] = min(distanceSquared,[],2)
    distanceTrans = distance';
    speedAux = speed;
    % speed(speed.^2 > distance) = sqrt(distance);
    
    for idx = 1:length(speed)
        if (speed(idx)*speed(idx) > distanceTrans(idx))
            speed(idx) = sqrt(distanceTrans(idx)) - 0.1;
        end
    end

    for idx = 1:length(agentY)
        posX = agentX(idx);
        posY = agentY(idx);
        R = radius(idx);
        if (distance(idx) < R^2)
            if (foodAgentX(idx,index(idx)) > 0)
                theta = atan(foodAgentY(idx,index(idx))/foodAgentX(idx,index(idx)));
                posX = posX + speed(idx)*cos(theta);
                posY = posY + speed(idx)*sin(theta);
            else
                theta = pi + atan(foodAgentY(idx,index(idx))/foodAgentX(idx,index(idx)));
                posX = posX + speed(idx)*cos(theta);
                posY = posY + speed(idx)*sin(theta);
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
end

