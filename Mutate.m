function population=Mutate(population,mutationProbability,mutationParameter,nGenes,mMin,mMax)
% Loops though every gene, and the gene is mutated with a
% probability=mutationProbability. The mutationParameter decides the range
% of the allowed mutation, and it is then checked whether or not the
% resulting gene value is within the allowed range. 

nAgents=size(population,2);

for i=1:nAgents
    for j=1:nGenes
        r=rand;
        if(r<mutationProbability)
            q=mutationParameter*(rand*2-1);
            population(1,i).chromosome(j)=population(1,i).chromosome(j)+q;
            if(population(1,i).chromosome(j)<mMin)
                population(1,i).chromosome(j)=mMin;
            end
            if(population(1,i).chromosome(j)>mMax)
                population(1,i).chromosome(j)=mMax;
            end
        end
    end
end

end

