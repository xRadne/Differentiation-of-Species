function alive = Die(population, parameter)
    populationSize = length(population);
    alive = population(rand(1,populationSize) > parameter);
end