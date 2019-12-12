function newPopulation = Walk(agentX,agentY,gridSize)
    for idx = 1:length(agentY)
        %agent = population(idx);
        for idx2 = 1:agent.chromosome(1) %Speed parameter
            randomNumber = randi(4);
            switch (randomNumber)
                case 1
                    agent.x = agent.x + 1;
                    break
                case 2
                    agent.x = agent.x - 1;
                    break
                case 3
                    agent.y = agent.y + 1;
                    break
                case 4
                    agent.y = agent.y - 1;
                    break
            end
            if agent.x == (gridSize+1)
                agent.x = 0;
            end
            if agent.x == -1
                agent.x = gridSize;
            end
            if agent.y == (gridSize+1)
                agent.y = 0;
            end
            if agent.y == -1
                agent.y = gridSize;
            end
        end
        population(idx) = agent;
    end
    newPopulation = population;
end

