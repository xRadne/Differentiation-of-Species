function mutatedChromosome=Mutate(mutationProbability,mutationParameter,offspringChromosome,mMin,mMax)
% Loops though every gene, and the gene is mutated with a
% probability=mutationProbability. The mutationParameter decides the range
% of the allowed mutation, and it is then checked whether or not the
% resulting gene value is within the allowed range. 
r=rand(size(offspringChromosome,1),1);
mutationIdx=find(r < mutationProbability);
q=mutationParameter*(rand(1,length(mutationIdx))*2-1);
offspringChromosome(mutationIdx)=offspringChromosome(mutationIdx)+q';


offspringChromosome(offspringChromosome >mMax)=mMax;
offspringChromosome(offspringChromosome <mMin)=mMin;


mutatedChromosome=offspringChromosome;


end

