%% K-means
K = 2;
X = [randn(20,2)+ones(20,2);
     randn(20,2)-ones(20,2)];
opts = statset('Display','final');
[cidx, ctrs] = kmeans(X, K, 'Distance','city', ...
                      'Replicates',5, 'Options',opts);
                  
hsvColor = linspace(0,1-1/K,K)'*[1 0 0] + [0 1 1];
color = hsv2rgb(hsvColor);
figure(1); clf;
hold on
for i = 1:K
    plot(X(cidx==i,1),X(cidx==i,2),'.','Color',color(i,:));
end
plot(ctrs(:,1),ctrs(:,2),'kx');
hold off
drawnow()
%% PlotGenomeClusters2D test
N = 100;
X = randn(N,1)+ones(N,1);
Y = randn(N,1)-ones(N,1);
K = 3;
PlotGenomeClusters2D(X,Y,K)

%% Clusterdata
X = [randn(5000,3) + [ 2  2  2];
     randn(5000,3) + [-2  2  0];
     randn(5000,3) + [ 0 -2  0]];

c = clusterdata(X,'linkage','ward','savememory','on','maxclust',4);

plot3(X(c==1,1),X(c==1,2),X(c==1,3),'r.', ...
      X(c==2,1),X(c==2,2),X(c==2,3),'b.', ...
      X(c==3,1),X(c==3,2),X(c==3,3),'g.', ...
      X(c==4,1),X(c==4,2),X(c==4,3),'y.');
 