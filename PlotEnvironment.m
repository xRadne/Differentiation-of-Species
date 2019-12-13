function [] = PlotEnvironment(agentX,agentY,foodX,foodY)
    pause(0.01);
    hold on
    plot(foodX,foodY,'or');
    plot(agentX,agentY,'.k');
    hold off
    drawnow
end