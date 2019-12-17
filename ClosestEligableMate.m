function iClosestEligableMate = ClosestEligableMate(agentX,agentY,agentChromosome,geneticDistanceParameter)
%GETCLOSESTELIGABLEMATE Summary of this function goes here
%   Detailed explanation goes here

nAgents = length(agentX);

geneticDistanceMatrix = GeneticDistance(agentChromosome);
possibleMates = geneticDistanceMatrix < geneticDistanceParameter;

distances = (agentX-agentX').^2 + (agentY-agentY').^2;
distances(~possibleMates) = inf;
distances = distances + diag(ones(1,nAgents)*inf);

[d, iClosestEligableMate] = min(distances);
iClosestEligableMate(d == inf) = 0;
end

