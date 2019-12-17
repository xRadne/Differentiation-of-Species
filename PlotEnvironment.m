function [] = PlotEnvironment(agentX,agentY,foodX,foodY,agentChromosome,foodAmount)
%pause(0.01);
%plot(foodX,foodY,'or');

% map=[zeros(1,length(agentX))',zeros(1,length(agentX))',linspace(1,0.001,length(agentX))'];
%colormap(map)
sizeFood=foodAmount.*200;
scatter(foodX,foodY,sizeFood,'r','filled')
hold on

sizeIndividual=agentChromosome(1,:).*100;
%plot(agentX,agentY,'.k');
%plot(agentX,agentY,'o','MarkerSize',Size)
scatter(agentX,agentY,sizeIndividual)%, sizeIndividual)
axis tight;
axis([0 100 0 100]);
hold on
I = imread('KondyorMassif3.png');
h = image(xlim,ylim,I);
uistack(h,'bottom')
hold off
drawnow
end