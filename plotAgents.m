function [xposition,yposition] = plotAgents(population)
cla

%xposition=zeros(1:length(population));
%yposition=zeros(1:length(population));
for i=1:length(population)
    xposition(i)=population(1,i).x;
    yposition(i)=population(1,i).y;
end
xposition=xposition(:,:);
yposition=yposition(:,:);

hold on
plot(xposition, yposition, 'o'); drawnow()

end