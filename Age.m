function newpopulation=Age(population,tDeath)
%make agents die after a certain amount of time, later on affected by how much they eat

% energy function rather than time function?

deathRow=[];
 for i=1:length(population)
     population(1,i).age=population(1,i).age + 1; 
     deathRow(i)=(population(1,i).age==tDeath);
 end
 deathRow=find(deathRow);
 if not(isempty(deathRow))
 population(deathRow)=[];
 end
%population(:,population(1,:).age == tDeath) =[]; should be able to make it
%faster without loop
newpopulation=population;
end