function components = ComputeComponents(chromosomes,distanceParameter)
    N = size(chromosomes, 2);
    
    gene1 = chromosomes(1,:);
    gene2 = chromosomes(2,:);

    geneDistancesSquared = (gene1-gene1').^2 + (gene2-gene2').^2;
    
    adjecency = geneDistancesSquared < distanceParameter^2 - diag(ones(1,N));
    G = graph(adjecency);
    components = conncomp(G); % Find connected components;
end