function [newPopulation,agentAge,agentX,agentY,chromosome] = Mate(population, geneticDistance, distanceParameter,matingProbability,nGenes,agentChromosome,agentAge,agentX,agentY,gridSize)
%GENETICDISTANCE Summary of this function goes here
%   Detailed explanation goes here

chromosome=agentChromosome.*[population;population];
chromosome=chromosome';
X=agentX.*population;
Y=agentY.*population;

nAgents=size(population,2);
offspring = zeros(1,nGenes);

%chromosome=zeros(nAgents,nGenes);
% for iAgent=1:nAgents
%     chromosome(iAgent,:)=population(1,iAgent).chromosome;
% end

iOffspring=0;
for i=1:nAgents
    for j=nAgents
        if(i~=j)
%             xi=population(1,i).x;
%             xj=population(1,i).x;
              xi=X(i);
              xj=X(i);
            if(xi==xj)
%                 yi=population(1,i).y;
%                 yj=population(1,i).y;
                  yi=Y(i);
                  yj=Y(i);
                distance=geneticDistance(i,j);
                r=rand;
                if(yi==yj && distance<distanceParameter && r<matingProbability)
                    iOffspring=iOffspring+1;
%                     disp('hej barn');
                    for iGene=1:nGenes
                        r=rand;
                        if(r<0.5)
                            offspring(iOffspring,:)=chromosome(i,:); 
                        else 
                            offspring(iOffspring,:)=chromosome(j,:);
                        end
                    end
%                     offspring(iOffspring,:)=offspringChromosome
                end
            end
        end
    end
end
%newAgents = [];
% for i = 1:size(offspring, 1)
%     %newAgents = [newAgents, Agent(offspring(i,:), 100)];
% end
chromosome=[chromosome', offspring'];
offspringX=randi([0, gridSize],1,length(offspring)); % is the grid 0 to 100?
offspringY=randi([0, gridSize],1,length(offspring));
agentX=[X,offspringX]; 
agentY=[Y,offspringY];
age=agentAge.*population;
offspringAge=zeros(1,length(offspring));
agentAge=[age,offspringAge];
newPopulation = [population, ones(1,length(offspring))];
end

