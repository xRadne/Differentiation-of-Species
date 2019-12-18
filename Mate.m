function [agentAge,agentX,agentY,agentChromosome,radius,agentHunger] = Mate(agentChromosome,agentAge,agentX,agentY,radius,foodX,foodY,foodRadius,matingDistance,geneticDistance,distanceParameter,matingProbability,sightParameter,gridSize,mutationProbability,mutationParameter,mMin,mMax,maxHunger,agentHunger)
%GENETICDISTANCE Summary of this function goes here
%   Detailed explanation goes here

nAgents=size(agentX,2);
nGenes=size(agentChromosome,2);
nFoodSources=size(foodX,2);

iOffspring=nAgents;
for i=1:nAgents
    for j=1:nAgents
        if(i~=j)
            distance=sqrt((agentX(i)-agentX(j))^2+(agentY(i)-agentY(j))^2);
            foodDistance1=zeros(1,nFoodSources);
            for iFood=1:nFoodSources
                foodDistance1(iFood)=sqrt((agentX(i)-foodX(iFood))^2+(agentY(i)-foodY(iFood))^2);
            end
            foodDistance2=zeros(1,nFoodSources);
            for iFood=1:nFoodSources
                foodDistance2(iFood)=sqrt((agentX(j)-foodX(iFood))^2+(agentY(j)-foodY(iFood))^2);
            end
            r=rand;
            
            if not(any(foodDistance1<foodRadius)) && not(any(foodDistance2<foodRadius)) && agentHunger(i)>0.5*maxHunger && agentHunger(j)>0.5*maxHunger
                if(distance<matingDistance && geneticDistance(i,j)<distanceParameter && r<matingProbability)
                    agentHunger(i)=0.5*maxHunger;
                    agentHunger(j)=0.5*maxHunger;
                    
                    iOffspring=iOffspring+1;
                    for iGene=1:nGenes
                        r=rand;
                        if(r<0.5)
                            agentChromosome(:,iOffspring)=agentChromosome(:,i);
                        else
                            agentChromosome(:,iOffspring)=agentChromosome(:,j);
                        end
                    end
                    agentChromosome(:,iOffspring) = Mutate(mutationProbability,mutationParameter,agentChromosome(:,iOffspring),mMin,mMax);
                    agentAge(iOffspring)=0;
                    agentX(iOffspring)=agentX(i)+matingDistance;
                    agentY(iOffspring)=agentY(i)+matingDistance;
                    radius(iOffspring)=sightParameter*rand;
                    agentHunger(iOffspring)=maxHunger*0.5;
                    
                end
            end
        end
    end
end
agentX(agentX>gridSize)=gridSize;
agentY(agentY>gridSize)=gridSize;
agentX(agentX<0)=0;
agentX(agentX<0)=0;
end

