
function [] = PlotEnvironment(agentX,agentY,foodX,foodY,agentChromosome,foodAmount,lowerX,midX,higherX,lowerY,higherY,gridSize)

    %map=[zeros(1,length(agentX))',zeros(1,length(agentX))',linspace(1,0.001,length(agentX))'];
    %colormap(map)
    axis([]);
    sizeFood=foodAmount.*200;
    scatter(foodX,foodY,sizeFood,'r','filled')
    hold on

    sizeIndividual=agentChromosome(1,:).*100;
    scatter(agentX,agentY,sizeIndividual,'w','filled')%, sizeIndividual)
    
   
    %valley
    
    plot([lowerX higherX],[lowerY lowerY],'k','LineWidth', 3)
    plot([lowerX lowerX],[lowerY higherY],'k','LineWidth', 3)
    plot([midX higherX],[higherY higherY],'k','LineWidth', 3)
    plot([higherX higherX],[higherY lowerY],'k','LineWidth', 3)
    

axis tight;
axis([0 gridSize 0 gridSize]);

I = imread('KondyorMassif5.png');
I3 = flipdim(I ,1);
h = image(xlim,ylim,I3,'AlphaData',0.7);
uistack(h,'bottom')
hold off
drawnow
end