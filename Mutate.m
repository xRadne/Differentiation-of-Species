function mutatedChromosome=Mutate(agentX,mutationProbability,mutationParameter,agentChromosome,mMin,mMax)
% Loops though every gene, and the gene is mutated with a
% probability=mutationProbability. The mutationParameter decides the range
% of the allowed mutation, and it is then checked whether or not the
% resulting gene value is within the allowed range. 
r=rand(2,length(agentX));
mutationIdx=find(r < mutationProbability);
q=mutationParameter*(rand(1,length(mutationIdx))*2-1);
agentChromosome(mutationIdx)=agentChromosome(mutationIdx)+q';


agentChromosome(agentChromosome >mMax)=mMax;
agentChromosome(agentChromosome <mMin)=mMin;


mutatedChromosome=agentChromosome;


end

