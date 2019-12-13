function [] = PlotEnvironment(agentX,agentY,foodX,foodY)
    pause(0.01);
    plot(foodX,foodY,'or');
    hold on
    plot(agentX,agentY,'.k');
    hold off
    drawnow
end