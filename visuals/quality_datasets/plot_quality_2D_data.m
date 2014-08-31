init_random_seed(0);
common
%%
low = -5;
high = 10;
XlimHere = [low, high];
YlimHere = [low, high];
hereRadius = 0.2;
nPoint = 500;

qualities = [0.59, 0.69, 0.79, 0.89, 0.99];

for iQuality = 1:length(qualities)
    figure('Position', figPositionSquare)
    %generate artificial teaching signals
    dim = 2;
    samplingAccuracyRnd = @() qualities(iQuality);
    isValid = false;
    while ~isValid
        [path, isValid] = sample_artificial_dataset_path(dim, samplingAccuracyRnd);
    end
    load(path) % load X, Y, accuracy

    dispatcher = Dispatcher(X, Y, true);

    plotX = [];
    plotY = [];
    for i = 1:nPoint
        label = randi(2);
        plotX = [plotX; dispatcher.get_sample(label)];
        plotY = [plotY; label];
    end
    plotpY = label_to_plabel(plotY, 1);


    scatterpie(plotX(:,1), plotX(:,2), plotpY, feedbackColors, hereRadius, 'EdgeColor', 'none');
    xlim(XlimHere)
    ylim(YlimHere)
    title(num2str(accuracy))
    axis square
end
