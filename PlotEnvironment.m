
function [] = PlotEnvironment(agentX,agentY,foodX,foodY,agentChromosome,foodAmount,lowerX,midX,higherX,lowerY,higherY,gridSize,foodType)

   % map=[linspace(1,0.001,length(foodType))',zeros(1,length(foodType))',zeros(1,length(foodType))'];
    %colormap(map)
    sizeFood=foodAmount.*200;
   scatter(foodX,foodY,sizeFood,'r','filled');%foodType,'filled')

   
%     caxis('manual' )
%     caxis([0 1])
%     colorbar
    hold on

    sizeIndividual=agentChromosome(1,:).*100;
    scatter(agentX,agentY,sizeIndividual,'MarkerFaceColor','k','MarkerEdgeColor',[0,0,0])%,'filled')%, sizeIndividual)
    
   
    %valley
    
%     plot([lowerX higherX],[lowerY lowerY],'k','LineWidth', 3)
%     plot([lowerX lowerX],[lowerY higherY],'k','LineWidth', 3)
%     plot([midX higherX],[higherY higherY],'k','LineWidth', 3)
%     plot([higherX higherX],[higherY lowerY],'k','LineWidth', 3)
    

axis tight;
axis([0 gridSize 0 gridSize]);

%I = imread('KondyorMassif5.png');
%I3 = flipdim(I ,1);
%h = image(xlim,ylim,I3,'AlphaData',0.7);
%uistack(h,'bottom')

I = imread('grass1.jpg');
I3 = flipdim(I ,1);
h = image(xlim,ylim,I3,'AlphaData',0.5);
uistack(h,'bottom')
hold off
end