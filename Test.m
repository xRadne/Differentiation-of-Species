clear all

n=10;
m=5;
agentX = rand(1,n);
agentY = rand(1,n);
foodX = rand(1,m);
foodY = rand(1,m);

distanceSquared = (foodX - agentX').^2 + (foodY - agentY').^2

R=0.5;

closeFood = distanceSquared < R^2
[d,i] = min(distanceSquared,[],2)

foodX(i)