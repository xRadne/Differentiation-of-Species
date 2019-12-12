function newpopulation=Age(population,maxLife)
%make agents die after a certain amount of time, later on affected by how much they eat

% energy function rather than time function?
% make age function probabilistic with the higher age, the higher the risk
% of dying
    populationSize = length(population);
    deathRow=[];
    
 for i=1:length(population)
     deathParameter=randi([1,maxLife],1);
     population(1,i).age=population(1,i).age + 1;
     alive(i)=(deathParameter > population(1,i).age);

    % alive(i)=population(randi([1,maxLife],populationSize) > population(1,:).age);
     %deathRow(i)=(population(1,i).age==tDeath);
 end
%  deathRow=find(deathRow);
%  if not(isempty(deathRow))
%  population(deathRow)=[];
%  end
%population(:,population(1,:).age == tDeath) =[]; should be able to make it
%faster without loop
%newpopulation=population;
newpopulation=population(alive);
 end