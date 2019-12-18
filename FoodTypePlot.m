figure(1); clf;

nFood = 100;
gridSize = 100;

% foodX = rand(1,nFood) * gridSize;
% foodY = rand(1,nFood) * gridSize;

[foodX, foodY] = meshgrid(0:gridSize,0:gridSize);

valleyX = 50;
valleyY = 50;

foodType = sqrt((foodX-valleyX).^2 + (foodY-valleyY).^2) / (sqrt(2)*gridSize/2);

contour(foodX,foodY,foodType, 0:0.1:1)