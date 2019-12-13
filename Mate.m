function [agentAge,agentX,agentY,agentChromosome] = Mate(agentChromosome,agentAge,agentX,agentY,radius,matingDistance,geneticDistance,distanceParameter,matingProbability,sightParameter,gridSize)
%GENETICDISTANCE Summary of this function goes here
%   Detailed explanation goes here

nAgents=size(agentX,2);
nGenes=size(agentChromosome,2);

iOffspring=nAgents;
for i=1:nAgents
    for j=1:nAgents
        if(i~=j)
            distance=sqrt((agentX(i)-agentX(j))^2+(agentY(i)-agentY(j))^2);
            r=rand;
            
            if(distance<matingDistance && geneticDistance(i,j)<distanceParameter && r<matingProbability)
                iOffspring=iOffspring+1;
                for iGene=1:nGenes
                    r=rand;
                    if(r<0.5)
                        agentChromosome(:,iOffspring)=agentChromosome(:,i);
                    else
                        agentChromosome(:,iOffspring)=agentChromosome(:,j);
                    end
                end
                agentAge(iOffspring)=0;
                agentX(iOffspring)=agentX(i)+matingDistance;
                agentY(iOffspring)=agentY(i)+matingDistance;
                radius(iOffspring)=sightParameter*rand;
                
            end
        end
    end
end
agentX(agentX>gridSize)=gridSize;
agentY(agentY>gridSize)=gridSize;
agentX(agentX<0)=0;
agentX(agentX<0)=0;

end

