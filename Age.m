function [agentAge,agentX,agentY,agentChromosome,agentHunger]=Age(agentX,agentY,agentChromosome,agentAge,maxLife,deathParameter,agentHunger,hungerParameter,maxHunger)

% age function. the higher age, the higher the risk of dying
 
     agentAge=agentAge+1; 

     deathVector=randi([1,maxLife],1,length(agentAge));
     deadIdx=find(agentAge > deathVector);
     deadIdx=deadIdx.*(rand(1,length(deadIdx))<deathParameter);
     deadIdx=nonzeros(deadIdx);
     
     agentAge(deadIdx)=[];
     agentX(deadIdx)=[];
     agentY(deadIdx)=[];
     agentChromosome(:,deadIdx)=[];
     agentHunger(deadIdx)=[];
     % 
%      tooOld=find(agentAge>maxLife);
%      agentAge(tooOld)=[];
%      agentX(tooOld)=[];
%      agentY(tooOld)=[];
%      agentChromosome(:,tooOld)=[];
      
 % starvation:
 
     agentHunger=agentHunger-hungerParameter;
     starve=find(agentHunger<0);
     agentHunger(starve)=[];
     agentAge(starve)=[];
     agentX(starve)=[];
     agentY(starve)=[];
     agentChromosome(:,starve)=[];
 
     % cap hunger at maxHunger
     agentHunger(agentHunger>maxHunger)=maxHunger;
 
 
 end