function [] = PlotGenomeClusters2D(gene1, gene2, components)
%PLOTGENOMECLUSTERS2D Components is a vector of integers specifying what
%specie/cluster/component an individual agent belongs to.
    phi = 1/2+sqrt(5)/2;

    % Plot Positions/Genes
    nComponents = max(components);
    goldenRatioSpread = mod(phi*(1:nComponents), 1);
    hue = goldenRatioSpread'*[1 0 0]; % Column vector with equally spaced hues
    hsvColor = hue + [0 1 1]; % Set saturation and brightness to 1 for all colors
    rgbColor = hsv2rgb(hsvColor); % Convert to RGB values

    hold on
    for c = 1:nComponents
        gene1Component = gene1(components == c);
        gene2Component = gene2(components == c);
        
        plot(gene1Component, gene2Component,'.','Color',rgbColor(c,:),'MarkerSize',50)
        plot(mean(gene1Component), mean(gene2Component),'kx','MarkerSize',50)
    end
    axis([0 1 0 1])
    drawnow
    hold off
end

