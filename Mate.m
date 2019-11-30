function newPopulation = Mate(population, geneticDistance, distanceParameter,matingProbability,nGenes)
%GENETICDISTANCE Summary of this function goes here
%   Detailed explanation goes here

nAgents=size(population,2);
offspring = zeros(1,nGenes);

chromosome=zeros(nAgents,nGenes);
for iAgent=1:nAgents
    chromosome(iAgent,:)=population(1,iAgent).chromosome;
end

iOffspring=0;
for i=1:nAgents
    for j=nAgents
        if(i~=j)
            xi=population(1,i).x;
            xj=population(1,i).x;
            if(xi==xj)
                yi=population(1,i).y;
                yj=population(1,i).y;
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
newAgents = [];
for i = 1:size(offspring, 1)
    newAgents = [newAgents, Agent(offspring(i,:), 100)];
end
newPopulation = [population, newAgents];
end

