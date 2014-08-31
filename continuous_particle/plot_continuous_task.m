clean
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));

analysisFolder = fullfile(pathstr, 'analysis');
if ~exist(analysisFolder, 'dir')
    mkdir(analysisFolder)
end

dist = zeros(200, 100, 4);
data = nan(4, 100, 2);

load(fullfile(analysisFolder, 'random_random_50'))
dist(:,:, 1) = log.dist;
data(1, :, 1) = log.dist(end, :);
data(1, :, 2) = log.dist(end, :);

load(fullfile(analysisFolder, 'random_active_50'))
dist(:,:, 2) = log.dist;
data(2, :, 1) = log.dist(end, :);
data(2, :, 2) = log.dist(end, :);

load(fullfile(analysisFolder, 'uncertainty_random_50'))
dist(:,:, 3) = log.dist;
data(3, :, 1) = log.dist(end, :);
data(3, :, 2) = log.dist(end, :);

load(fullfile(analysisFolder, 'uncertainty_active_50'))
dist(:,:, 4) = log.dist;
data(4, :, 1) = log.dist(end, :);
data(4, :, 2) = log.dist(end, :);


%%

% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Courier')
DefaultAxesFontSize = 25;
set(0,'DefaultAxesFontSize', DefaultAxesFontSize)
set(0,'DefaultAxesFontWeight','bold')
set(0,'DefaultAxesLineWidth', 2.5)

pltMargin = 0.05;
pltSegmentMargin = 1;

niceBlue = [0.2, 0.4, 0.8];
niceGreen = [0.4, 0.8, 0.2];
niceGray = [0.2, 0.2, 0.2];
niceOrange = [0.9, 0.5, 0];
niceRed = [1, 0.2, 0.2];

figPosition = [200, 300, 800, 700];
figPosition2 = [200, 300, 500, 700];
figPositionFullScreen = [1, 74, 1280, 632];


OutlierMarker = 'x';
OutlierMarkerSize = 10;
OutlierMarkerFaceColor = 'k';
OutlierMarkerEdgeColor = 'k';
WidthE = 0.6;
WidthL = 0.5;
WidthS = 0.6;

labelNames = {'Sampling methods', 'Distance to goal'};

dimColor = [niceBlue;niceGray;niceGreen;niceOrange];
legendNames = {'random random', 'random active', 'uncertainty random', 'uncertainty active'};

%%

figure('Position', figPosition2)

aboxplot(data([1, 2, 3, 4], :, :),'labels',labelNames, ...
    'Colormap', dimColor , ...
    'OutlierMarker', OutlierMarker, ...
    'OutlierMarkerSize', OutlierMarkerSize, ...
    'OutlierMarkerEdgeColor', OutlierMarkerEdgeColor, ...
    'OutlierMarkerFaceColor', OutlierMarkerFaceColor, ...
    'WidthE', WidthE, ...
    'WidthL', WidthL,...
    'WidthS', WidthS);

% xlabel('Dataset Accuracies');
ylabel('Distance to goal');
[legh,objh,outh,outm] = legend(legendNames{:}, 'Location', 'NE');
% legend('boxoff')
set(legh,'linewidth',1);
% 
hold on
plot([-100 100], [0, 0], 'k--')
xlim([0.7, 1.3])
ylim([-0.01 0.25])
set(gca, 'box', 'off')

%%

meandist = mean(dist, 2);
stddist = std(dist, 0, 2)/sqrt(100);

figure('Position', figPosition)
hold on

h1 = shadedErrorBar(1:200, meandist(:,1,1), stddist(:,1,1), {'color', niceBlue}, 1);
h2 = shadedErrorBar(1:200, meandist(:,1,2), stddist(:,1,2), {'color', niceGray}, 1);
h3 = shadedErrorBar(1:200, meandist(:,1,3), stddist(:,1,3), {'color', niceGreen}, 1);
h4 = shadedErrorBar(1:200, meandist(:,1,4), stddist(:,1,4), {'color', niceOrange}, 1);

xlabel('Iterations');
ylabel('Distance to goal');

[legh,objh,outh,outm] = legend([h1.patch h2.patch h3.patch h4.patch], legendNames{:}, 'Location', 'NE');
% legend('boxoff')
set(legh,'linewidth',2);
% 
xlim([0,200])
ylim([0,0.4])
% set(gca, 'box', 'off')



%%
pvalues = ones(4,4);
for i = 1:4
    for j = 1:4
        pvalues(i, j) = ranksum(data(i,:,1), data(j,:,1), 'tail', 'right');
    end 
end

pvalues(1,2)
pvalues(1,3)
pvalues(2,3)
pvalues(3,4)

%%

% scatter(rec.position(:,1), rec.position(:,2))
% hold on
% scatter(rec.goalHypothesis(1,1,:), rec.goalHypothesis(1,2,:), 'g', 'filled')
% scatter(rec.teacherHypothesis(:,1), rec.teacherHypothesis(:,2), 'r', 'filled')
