function distanceMatrix = GeneticDistance(agentChromosome)
% Calculates the genetic distance between the individuals in the
% population. distance(j,k) is the distance between individual j and k. The
% distance in defined as the sum of the difference between the individual
% genes. 
% 

chromosome=agentChromosome';
[~,nAgents]=size(agentChromosome);
distanceMatrix=zeros(nAgents);

for j=1:nAgents
    for k=1:nAgents
        distance=chromosome(j,:)-chromosome(k,:);
        distance=sum(distance);
        distanceMatrix(j,k)=abs(distance);
    end
end

end

