function [averageGeneticDistance, differentiationDegrees] = Evaluate(population)
%EVALUATE Summary of this function goes here
%   Detailed explanation goes here
    populationSize = size(population, 2);
    nGenes = size(population(1).chromosome, 2);
    distances = GeneticDistance(population);
    
    averageGeneticDistance = sum(sum(distances));
    
    % Cluster diffenentiation with K-Means clustering
    K = 2;
    genomes = zeros(populationSize, nGenes);
%     clusterIndex = kmeans(genomes, K);
%     genomesCluster1 = [];
%     genomesCluster2 = [];
    
    differentiationDegrees = 1;
end