function [] = PlotGenomeClusters2D(X,Y,K)
%PLOTGENOMECLUSTERS2D Plots clusters of a 2D dataset.
%    X,Y are column vectors. K is the number of clusters to find
    opts = statset('Display','final');
    [cidx, ctrs] = kmeans([X Y], K, 'Distance','city', ...
                          'Replicates',5, 'Options',opts);

    hsvColor = linspace(0,1-1/K,K)'*[1 0 0]; % Column vector with equally spaced hues
    hsvColor = hsvColor+ [0 1 1]; % Set saturation and brightness to 1 for all colors
    rgbColor = hsv2rgb(hsvColor); % Convert to RGB values

    figure(1); clf;
    hold on
    for i = 1:K
        plot(X(cidx==i),Y(cidx==i),'.','Color',rgbColor(i,:));
    end
    plot(ctrs(:,1),ctrs(:,2),'kx');
    hold off
    drawnow()
end

