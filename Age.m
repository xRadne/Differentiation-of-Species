function [aliveAge,aliveX,aliveY,aliveChromosome]=Age(agentX,agentY,agentChromosome,agentAge,maxLife)

% age function. the higher age, the higher the risk of dying
 
     agentAge=agentAge+1; 

     deathParameter=randi([1,maxLife],1,length(agentAge));
     aliveIdx=find(agentAge < deathParameter);
     aliveAge=agentAge(aliveIdx);
     aliveX=agentX(aliveIdx);
     aliveY=agentY(aliveIdx);
     aliveChromosome=agentChromosome(:,aliveIdx);
    
 end