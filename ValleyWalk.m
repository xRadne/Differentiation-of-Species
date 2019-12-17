function [newAgentX,newAgentY] = ValleyWalk(agentX,agentY,speed,radius,foodX,foodY,foodAmount,hungerParameter,maxHunger,gridSize,lowerX,midX,higherX,lowerY,higherY,iClosestFood,squaredDistanceClosestFood,iClosestEligableMate,goingRadius,mateRadius)
    
    nAgents = length(agentY);
    newAgentX = zeros(1,nAgents);
    newAgentY = zeros(1,nAgents);
    foodAgentX = foodX - agentX';
    foodAgentY = foodY - agentY';
    %distanceSquared = (foodAgentX).^2 + (foodAgentY).^2;
    %[distance,index] = min(distanceSquared,[],2);
    index=iClosestFood;
    distance=squaredDistanceClosestFood;
    speedAux = speed;
    logicalHungerParameter = hungerParameter >= maxHunger;
    % speed(speed.^2 > distance) = sqrt(distance);
    
    for idx = 1:length(speed)
        R = radius(idx);
        if (speed(idx)*speed(idx) > distance(idx)) & (foodAmount(index(idx))>=0.1) & (distance(idx) < R^2) & (logicalHungerParameter(idx) ~= 1)
            speed(idx) = sqrt(distance(idx)) - 0.1; 
        end
    end

    for idx = 1:length(agentY)
        posX = agentX(idx);
        posY = agentY(idx);
        R = radius(idx);
        if iClosestEligableMate(idx) == 0
            distanceClosestAgent = 1000;
        else
            distanceClosestAgent = (agentX(idx) - agentX(iClosestEligableMate(idx)))^2 + (agentY(idx) - agentY(iClosestEligableMate(idx)))^2;
        end
        if (distance(idx) < R^2) & foodAmount(index(idx))>=0.1 & (logicalHungerParameter(idx) ~= 1)
            if (foodAgentX(idx,index(idx)) > 0)
                theta = atan(foodAgentY(idx,index(idx))/foodAgentX(idx,index(idx)));
                posX = posX + speed(idx)*cos(theta);
                posY = posY + speed(idx)*sin(theta);
            else
                theta = pi + atan(foodAgentY(idx,index(idx))/foodAgentX(idx,index(idx)));
                posX = posX + speed(idx)*cos(theta);
                posY = posY + speed(idx)*sin(theta);
            end
        elseif (distanceClosestAgent < goingRadius^2) & (hungerParameter(idx) >= 0.5*hungerParameter)
            if distanceClosestAgent > mateRadius^2
                if (speed(idx)+speed(iClosestEligableMate(idx))) > goingRadius
                speed(idx) = goingRadius/2 - 0.05;
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
            theta = -pi + rand*2*pi;
            aux1 = posX + speedAux(idx)*cos(theta);
            aux2 = posY + speedAux(idx)*sin(theta);
            % If the agent is inside the valley.
            if (posX > lowerX) & (posX < higherX) & (posY > lowerY) & (posY < higherY)
                % If the agent wants to go outside the valley.
                if (aux1 <= lowerX) | (aux1 >= higherX) | (aux2 <= lowerY) | (aux2 >= higherY)
                    % Theta belongs to the first quadrant.
                    if (theta <= pi/2) & (theta > 0)
                        phi = atan((higherY-posY)/(higherX-posX));
                        alpha = atan((higherY-posY)/(midX-posX));
                        % Collision
                        if (theta < alpha) | (alpha < 0)
                            % Horizontal wall.
                            if theta >= phi
                                d1 = (higherY-posY)/sin(theta);
                                posX = posX + d1*cos(theta);
                                posY = higherY;
                                aux3 = posX + (speedAux(idx)-d1)*cos(theta);
                                aux4 = posY - (speedAux(idx)-d1)*sin(theta);
                                if (aux3 <= lowerX) | (aux3 >= higherX) | (aux4 <= lowerY) | (aux4 >= higherY)
                                    d2 = (higherX - posX)/cos(theta);
                                    posY = posY - d2*sin(theta);
                                    posX = higherX;
                                    posX = posX - (speedAux(idx)-d1-d2)*cos(theta);
                                    posY = posY - (speedAux(idx)-d1-d2)*sin(theta);
                                else
                                    posX = aux3;
                                    posY = aux4;
                                end
                            % Vertical wall
                            else
                                d1 = (higherX - posX)/cos(theta);
                                posY = posY + d1*sin(theta);
                                posX = higherX;
                                aux3 = posX - (speedAux(idx)-d1)*cos(theta);
                                aux4 = posY + (speedAux(idx)-d1)*sin(theta);
                                if (aux3 <= lowerX) | (aux3 >= higherX) | (aux4 <= lowerY) | (aux4 >= higherY)
                                    d2 = (higherY - posY)/sin(theta);
                                    posX = posX - d2*cos(theta);
                                    posY = higherY;
                                    posX = posX - (speedAux(idx)-d1-d2)*cos(theta);
                                    posY = posY - (speedAux(idx)-d1-d2)*sin(theta);
                                else
                                    posX = aux3;
                                    posY = aux4;
                                end
                            end
                        % The agent goes through the entry.
                        else
                            posX = aux1;
                            posY = aux2;
                        end
                    % theta belongs to the second quadrant.    
                    elseif (theta > pi/2)
                        phi = atan((higherY-posY)/(posX-lowerX));
                        thetaAux = pi - theta;
                        alpha = -atan((higherY-posY)/(midX-posX));
                        % posX > midX
                        if alpha > 0
                            if thetaAux >= alpha
                            % Horizontal wall
                                d1 = (higherY - posY)/sin(thetaAux);
                                posX = posX - d1*cos(thetaAux);
                                posY = higherY;
                                aux4 = posY - (speedAux(idx)-d1)*sin(thetaAux);
                                aux3 = posX - (speedAux(idx)-d1)*cos(thetaAux);
                                if (aux3 <= lowerX) | (aux3 >= higherX) | (aux4 <= lowerY) | (aux4 >= higherY)
                                    d2 = (posX - lowerX)/cos(thetaAux);
                                    posY = posY - d2*sin(thetaAux);
                                    posX = lowerX;
                                    posX = posX + (speedAux(idx)-d1-d2)*cos(thetaAux);
                                    posY = posY - (speedAux(idx)-d1-d2)*sin(thetaAux);
                                else
                                    posX = aux3;
                                    posY = aux4;
                                end
                            % Vertical wall
                            elseif thetaAux <= phi
                                d1 = (posX - lowerX)/cos(thetaAux);
                                posY = posY + d1*sin(thetaAux);
                                posX = lowerX;
                                posY = posY + (speedAux(idx)-d1)*sin(thetaAux);
                                posX = posX + (speedAux(idx)-d1)*cos(thetaAux);
                            % The agent goes through the entry.
                            else
                                posX = aux1;
                                posY = aux2;
                            end
                        % posX < midX
                        else
                            % Vertical wall
                            if thetaAux <= phi
                                d1 = (posX - lowerX)/cos(thetaAux);
                                posY = posY + d1*sin(thetaAux);
                                posX = lowerX;
                                posY = posY + (speedAux(idx)-d1)*sin(thetaAux);
                                posX = posX + (speedAux(idx)-d1)*cos(thetaAux);
                            else
                                posX = aux1;
                                posY = aux2;
                            end
                        end
                    % Theta belongs to the third quadrant.
                    elseif (theta <= -pi/2)
                        thetaAux = pi + theta;
                        phi = atan((lowerY-posY)/(lowerX-posX));
                        % Vertical wall
                        if thetaAux <= phi
                            d1 = (posX - lowerX)/cos(thetaAux);
                            posY = posY - d1*sin(thetaAux);
                            posX = lowerX;
                            aux4 = posY - (speedAux(idx)-d1)*sin(thetaAux);
                            aux3 = posX + (speedAux(idx)-d1)*cos(thetaAux);
                            if (aux3 <= lowerX) | (aux3 >= higherX) | (aux4 <= lowerY) | (aux4 >= higherY)
                                d2 = (posY - lowerY)/sin(thetaAux);
                                posX = posX + d2*cos(thetaAux);
                                posY = lowerY;
                                posY = posY + (speedAux(idx)-d1-d2)*sin(thetaAux);
                                posX = posX + (speedAux(idx)-d1-d2)*cos(thetaAux);
                            else
                                posX = aux3;
                                posY = aux4;
                            end
                        % Horizontal wall
                        else
                            d1 = (posY - lowerY)/sin(thetaAux);
                            posX = posX - d1*cos(thetaAux);
                            posY = lowerY;
                            aux3 = posX - (speedAux(idx)-d1)*cos(thetaAux);
                            aux4 = posY + (speedAux(idx)-d1)*cos(thetaAux);
                            if (aux3 <= lowerX) | (aux3 >= higherX) | (aux4 <= lowerY) | (aux4 >= higherY)
                                d2 = (posX - lowerX)/cos(thetaAux);
                                posY = posY + d2*sin(thetaAux);
                                posX = lowerX;
                                posX = posX + (speedAux(idx)-d1)*cos(thetaAux);
                                posY = posY + (speedAux(idx)-d1)*sin(thetaAux);
                            else
                                posX = aux3;
                                posY = aux4;
                            end
                        end
                    % Theta belongs to the forth quadrant.
                    else
                        thetaAux = -theta;
                        phi = atan((posY-lowerY)/(higherX-posX));
                        % Vertical wall
                        if thetaAux <= phi
                            d1 = (higherX - posX)/cos(thetaAux);
                            posY = posY - d1*sin(thetaAux);
                            posX = higherX;
                            aux4 = posY - (speedAux(idx)-d1)*sin(thetaAux);
                            aux3 = posX - (speedAux(idx)-d1)*cos(thetaAux);
                            if (aux3 <= lowerX) | (aux3 >= higherX) | (aux4 <= lowerY) | (aux4 >= higherY)
                                d2 = (posY - lowerY)/sin(thetaAux);
                                posX = posX - d2*cos(thetaAux);
                                posY = lowerY;
                                posY = posY + (speedAux(idx)-d1-d2)*sin(thetaAux);
                                posX = posX - (speedAux(idx)-d1-d2)*cos(thetaAux);
                            else
                                posX = aux3;
                                posY = aux4;
                            end
                        % Horizontal wall
                        else
                            d1 = (posY - lowerY)/sin(thetaAux);
                            posX = posX + d1*cos(thetaAux);
                            posY = lowerY;
                            aux3 = posX + (speedAux(idx)-d1)*cos(thetaAux);
                            aux4 = posY + (speedAux(idx)-d1)*sin(thetaAux);
                            if (aux3 <= lowerX) | (aux3 >= higherX) | (aux4 <= lowerY) | (aux4 >= higherY)
                                d2 = (higherX - posX)/cos(thetaAux);
                                posY = posY + d2*sin(thetaAux);
                                posX = higherX;
                                posX = posX - (speedAux(idx)-d1-d2)*cos(thetaAux);
                                posY = posY + (speedAux(idx)-d1-d2)*sin(thetaAux);
                            else
                                posX = aux3;
                                posY = aux4;
                            end
                        end
                    end
                % The agent wants to stay in the valley.    
                else
                    posX = aux1;
                    posY = aux2;
                end
            % The agent is outside the valley.
            else
                % The agent wants to go inside the valley.
                if (aux1 >= lowerX) & (aux1 <= higherX) & (aux2 >= lowerY) & (aux2 <= higherY)
                    % Theta belongs to the first quadrant.
                    if (theta <= pi/2) & (theta > 0)
                        phi = atan((lowerY-posY)/(lowerX-posX));
                        % Vertical wall
                        if (theta >= phi) & (posX < 2)
                            d1 = (lowerX-posX)/cos(theta);
                            posY = posY + d1*sin(theta);
                            posX = lowerX;
                            posX = posX - (speedAux(idx)-d1)*cos(theta);
                            posY = posY + (speedAux(idx)-d1)*sin(theta);
                        % Horizontal wall
                        else
                            d1 = (lowerY-posY)/sin(theta);
                            posX = posX + d1*cos(theta);
                            posY = lowerY;
                            posX = posX + (speedAux(idx)-d1)*cos(theta);
                            posY = posY - (speedAux(idx)-d1)*sin(theta);
                        end
                    % Theta belongs to the second quadrant.
                    elseif (theta > pi/2)
                        phi = atan((lowerY-posY)/(posX-higherX));
                        thetaAux = pi - theta;
                        % Vertical wall
                        if (thetaAux >= phi) & (posX > 5)
                            d1 = (posX - higherX)/cos(thetaAux);
                            posY = posY + d1*sin(thetaAux);
                            posX = higherX;
                            posX = posX + (speedAux(idx)-d1)*cos(thetaAux);
                            posY = posY + (speedAux(idx)-d1)*sin(thetaAux);
                        % Horizontal wall
                        else
                            d1 = (lowerY - posY)/sin(thetaAux);
                            posX = posX - d1*cos(thetaAux);
                            posY = lowerY;
                            posY = posY - (speedAux(idx)-d1)*sin(thetaAux);
                            posX = posX - (speedAux(idx)-d1)*cos(thetaAux);
                        end
                    % Theta belongs to the third quadrant.
                    elseif (theta <= -pi/2)
                        thetaAux = pi + theta;
                        phi = atan((higherY-posY)/(higherX-posX));
                        alpha = atan((posY-higherY)/(posX-midX));
                        % Vertical wall
                        if (theta >= phi) & (posX > higherX)
                            d1 = (posX - higherX)/cos(thetaAux);
                            posY = posY - d1*sin(thetaAux);
                            posX = higherX;
                            posX = posX + (speedAux(idx)-d1)*cos(thetaAux);
                            posY = posY - (speedAux(idx)-d1)*cos(thetaAux);
                        % Horizontal wall
                        else
                            if posY > higherY
                                if (thetaAux <= alpha) & (alpha > 0)
                                    posX = aux1;
                                    posY = aux2;
                                elseif (thetaAux > alpha) & (alpha > 0)
                                    d1 = (posY - higherY)/sin(thetaAux);
                                    posX = posX - d1*cos(thetaAux);
                                    posY = higherY;
                                    posY = posY + (speedAux(idx)-d1)*sin(thetaAux);
                                    posX = posX - (speedAux(idx)-d1)*cos(thetaAux);
                                else
                                    posX = aux1;
                                    posY = aux2;
                                end
                            end
                        end
                    % Theta belongs to the forth quadrant.
                    else
                        thetaAux = -theta;
                        phi = atan((posY-higherY)/(lowerX-posX));
                        alpha = atan((posY-higherY)/(midX-posX));
                        % Vertical wall
                        if (thetaAux >= phi) & (posX < lowerX)
                            d1 = (lowerX - posX)/cos(thetaAux);
                            posY = posY - d1*sin(thetaAux);
                            posX = lowerX;
                            posX = posX - (speedAux(idx)-d1)*cos(thetaAux);
                            posY = posY - (speedAux(idx)-d1)*sin(thetaAux);
                        % Horizontal wall
                        else
                            if posY > higherY
                                if (thetaAux >= alpha) & (alpha > 0)
                                    posX = aux1;
                                    posY = aux2;
                                else
                                    d1 = (posY - higherY)/sin(thetaAux);
                                    posX = posX + d1*cos(thetaAux);
                                    posY = higherY;
                                    posY = posY + (speedAux(idx)-d1)*sin(thetaAux);
                                    posX = posX + (speedAux(idx)-d1)*cos(thetaAux);
                                end
                            end
                        end
                    end
                else
                    posX = aux1;
                    posY = aux2;
                end
            end
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