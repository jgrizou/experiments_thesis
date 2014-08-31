clean
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));

%%
analysisFolder = fullfile(pathstr, 'analysis');

methodFolders = getfilenames(analysisFolder);
nWorld = 3;
nMethod = length(methodFolders)/nWorld;


nSegment = 2;
maxElem = 50; %nb of element max per category

worldNames = cell(nMethod, nSegment);
methodNames = cell(nMethod, nSegment);
nSim = zeros(nMethod, nSegment);
timeFirst = nan(nMethod, maxElem, nSegment);
nFirstNonReached = nan(nMethod, nSegment);
nCorrect = nan(nMethod, maxElem, nSegment);
nWrong = nan(nMethod, maxElem, nSegment);
ratioFirstWrong = zeros(nMethod, nSegment);
timeToFirstTargetAfterConfidence = nan(nMethod, maxElem, nSegment);

for iMethodFile = 1:length(methodFolders)
    
    filename = fullfile(methodFolders{iMethodFile}, 'analysisLogs.mat');
    [~, fname, ~] = fileparts(methodFolders{iMethodFile});
    load(filename)
    
    fname
    
    %correct time per target
    timeFirstTarget = analysisLogs.timePerTarget(:,1);
    tmpnFirst = sum(timeFirstTarget == -1);
    timeFirstTarget(timeFirstTarget == -1) = size(analysisLogs.timePerTarget, 2);
    
    if iMethodFile <= nMethod
        iMethod = iMethodFile;
    elseif iMethodFile <= 2*nMethod
        iMethod = iMethodFile - nMethod;  
    else
        iMethod = iMethodFile - 2 * nMethod;
    end
    
    if strstartswith(fname, 'gridworld_5x5')%gridworld
        iSegment = 1;
        worldNames{iMethod, iSegment} = 'gridworld_5x5';
        tmp = strgsub(fname, 'gridworld_5x5_', '');
        methodNames{iMethod, iSegment} = strgsub(tmp, '_', ' ');
    elseif strstartswith(fname, 'gridworld')%gridworld
        iSegment = 2;
        worldNames{iMethod, iSegment} = 'gridworld';
        tmp = strgsub(fname, 'gridworld_', '');
        methodNames{iMethod, iSegment} = strgsub(tmp, '_', ' ');
    else
        iSegment = 3;
        worldNames{iMethod, iSegment} = 'pick_and_place';
        tmp = strgsub(fname, 'pick_and_place_', '');
        methodNames{iMethod, iSegment} = strgsub(tmp, '_', ' ');
    end
        
    nSim(iMethod, iSegment) = length(analysisLogs.filename);
    
    timeFirst(iMethod, 1:length(timeFirstTarget) ,iSegment) = timeFirstTarget;
    
    nFirstNonReached(iMethod, iSegment) = tmpnFirst;
    
    tmpCorrect = sum(analysisLogs.correctReach, 2);
    nCorrect(iMethod, 1:length(tmpCorrect) ,iSegment) = tmpCorrect;
    
    tmpWrong = sum(analysisLogs.wrongReach, 2);
    nWrong(iMethod, 1:length(tmpWrong) ,iSegment) = tmpWrong;
    
    tmpRatio = mean(analysisLogs.targetCorrect(:,1) == 0);
    ratioFirstWrong(iMethod,iSegment) = tmpRatio;
    
    
    tmp = analysisLogs.confReachTimePerTarget(:,1);
    tmp(tmp == -1) = nan;
    timeToFirstTargetAfterConfidence(iMethod,1:length(tmp), iSegment) = tmp; 
end

idx = isnan(timeToFirstTargetAfterConfidence);
timeToFirstTargetAfterConfidence(idx) = 0;
timeFirstConfidence = timeFirst - timeToFirstTargetAfterConfidence;

timeToFirstTargetAfterConfidence(idx) = nan;
timeToFirstTargetAfterConfidence(4,:,2) = -10;

%% reranking

reranking = [4, 2, 1, 3, 6, 5];

methodNames = methodNames(reranking, :);
timeFirst = timeFirst(reranking, :, :);
timeFirstConfidence = timeFirstConfidence(reranking, :, :);
timeToFirstTargetAfterConfidence = timeToFirstTargetAfterConfidence(reranking, :, :);

nSim = nSim(reranking, :);
ratioFirstWrong = ratioFirstWrong(reranking, :);
nFirstNonReached = nFirstNonReached(reranking, :);

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
niceGray = [0.5, 0.5, 0.5];
niceOrange = [0.9, 0.5, 0];
niceRed = [1, 0.2, 0.2];
nicePurple = [0.6, 0.07, 0.86];

figPosition = [200, 300, 800, 700];
figPositionFullScreen = [1, 74, 1280, 632];

OutlierMarker = 'x';
OutlierMarkerSize = 10;
OutlierMarkerFaceColor = 'k';
OutlierMarkerEdgeColor = 'k';
WidthE = 0.8;
WidthL = 0.8;
WidthS = 0.8;

labelNames = {'Grid 5x5', 'Grid 25x25', 'Pick and place'};

dimColor = [nicePurple;niceBlue;niceGreen;niceOrange;niceGray;niceRed];
legendNames = {'Random', ...
    '\epsilon-greedy 0.5',...
    '\epsilon-greedy 0.1',...
    'Greedy',...
    'Uncertainty task',...
    'Uncertainty signal'};

%% time first
figure('Position', figPositionFullScreen)

aboxplot(timeFirst,'labels',labelNames, ...
    'Colormap', dimColor , ...
    'OutlierMarker', OutlierMarker, ...
    'OutlierMarkerSize', OutlierMarkerSize, ...
    'OutlierMarkerEdgeColor', OutlierMarkerEdgeColor, ...
    'OutlierMarkerFaceColor', OutlierMarkerFaceColor, ...
    'WidthE', WidthE, ...
    'WidthL', WidthL,...
    'WidthS', WidthS);

ylabel('Nb of steps to first target');
[legh,objh,outh,outm] = legend(legendNames{:}, 'Location', 'BO');
legend('boxoff')
set(legh,'linewidth',1);

hold on
plot([0, 9.5], [100, 100], 'k--')
ylim([0 105])
set(gca, 'box', 'off')

%% time first conf
figure('Position', figPositionFullScreen)

aboxplot(timeFirstConfidence,'labels',labelNames, ...
    'Colormap', dimColor , ...
    'OutlierMarker', OutlierMarker, ...
    'OutlierMarkerSize', OutlierMarkerSize, ...
    'OutlierMarkerEdgeColor', OutlierMarkerEdgeColor, ...
    'OutlierMarkerFaceColor', OutlierMarkerFaceColor, ...
    'WidthE', WidthE, ...
    'WidthL', WidthL,...
    'WidthS', WidthS);

ylabel('Nb of steps to first confidence');
[legh,objh,outh,outm] = legend(legendNames{:}, 'Location', 'BO');
legend('boxoff')
set(legh,'linewidth',1);

hold on
plot([0, 9.5], [100, 100], 'k--')
ylim([0 105])
set(gca, 'box', 'off')

%% diff
figure('Position', figPosition)

aboxplot(timeToFirstTargetAfterConfidence,'labels',labelNames, ...
    'Colormap', dimColor , ...
    'OutlierMarker', OutlierMarker, ...
    'OutlierMarkerSize', OutlierMarkerSize, ...
    'OutlierMarkerEdgeColor', OutlierMarkerEdgeColor, ...
    'OutlierMarkerFaceColor', OutlierMarkerFaceColor, ...
    'WidthE', WidthE, ...
    'WidthL', WidthL,...
    'WidthS', WidthS);

ylabel('Nb of steps to target once confident');
[legh,objh,outh,outm] = legend(legendNames{:}, 'Location', 'NW');
legend('boxoff')
set(legh,'linewidth',1);

hold on 
plot([-100, 100], [0,0], 'k--')

ylim([-1 25])
set(gca, 'box', 'off')



%%

nSim

nWrongFirstTarget = ratioFirstWrong .* nSim

nFirstReached = 50 - nFirstNonReached

%% n correct
% figure('Position', figPosition)
% 
% aboxplot(nCorrect,'labels',labelNames, ...
%     'Colormap', dimColor , ...
%     'OutlierMarker', OutlierMarker, ...
%     'OutlierMarkerSize', OutlierMarkerSize, ...
%     'OutlierMarkerEdgeColor', OutlierMarkerEdgeColor, ...
%     'OutlierMarkerFaceColor', OutlierMarkerFaceColor, ...
%     'WidthE', WidthE, ...
%     'WidthL', WidthL,...
%     'WidthS', WidthS);

% xlabel('Dataset Accuracies');
% ylabel('Number of correctly reached target');
% [legh,objh,outh,outm] = legend(legendNames{:}, 'Location', 'NW');
% % legend('boxoff')
% set(legh,'linewidth',1);
% %
% hold on
% plot([0, 11], [0, 0], 'k--')
% ylim([-2 60])
% set(gca, 'box', 'off')

%% n wrong
% figure('Position', figPosition)
% 
% aboxplot(nWrong,'labels',labelNames, ...
%     'Colormap', dimColor , ...
%     'OutlierMarker', OutlierMarker, ...
%     'OutlierMarkerSize', OutlierMarkerSize, ...
%     'OutlierMarkerEdgeColor', OutlierMarkerEdgeColor, ...
%     'OutlierMarkerFaceColor', OutlierMarkerFaceColor, ...
%     'WidthE', WidthE, ...
%     'WidthL', WidthL,...
%     'WidthS', WidthS);

% xlabel('Dataset Accuracies');
% ylabel('Number of incorrectly reached target');
% [legh,objh,outh,outm] = legend(legendNames{:}, 'Location', 'NW');
% % legend('boxoff')
% set(legh,'linewidth',1);
% %
% hold on
% plot([0, 11], [0, 0], 'k--')
% ylim([-2 30])
% set(gca, 'box', 'off')

%%

% bw_title = [];
% bw_xlabel = 'Dataset Accuracies';
% bw_colormap = dimColor;
% gridstatus = [];
% bw_legend = legendNames;
% error_sides = [];
% legend_type = [];


% bw_ylabel = 'Number of simulated exeperiment';
% figure('Position', figPosition)
% hold on
% barweb(nSim', zeros(nSegment, nMethod), 0.8, labelNames, bw_title, bw_xlabel, bw_ylabel, bw_colormap, gridstatus, bw_legend, error_sides, legend_type);
% 
% bw_ylabel = 'Ratio of incorrectly reached first target';
% figure('Position', figPosition)
% hold on
% barweb(ratioFirstWrong', zeros(nSegment, nMethod), 0.8, labelNames, bw_title, bw_xlabel, bw_ylabel, bw_colormap, gridstatus, bw_legend, error_sides, legend_type);
% 


%% save plots
% [pathstr, ~, ~] = fileparts(mfilename('fullpath'));
% plotFolder = fullfile(pathstr, 'plot');
% if ~exist(plotFolder, 'dir')
%    mkdir(plotFolder)
% end
%
% plotFormats = {'png', 'eps'};
%
% plotFilenames = {'timefirst', 'correct', 'error', 'nSim', 'errorfirst'};
%
% save_all_images(plotFolder, plotFormats, plotFilenames)
% close all
%
% %% save data
%
% resultFile = fullfile(plotFolder, 'results.mat');
% dataToSave = {'nSim', 'timeFirst', 'nCorrect', 'nWrong', 'ratioFirstWrong', ...
%     'labelNames', 'legendNames'};
% save(resultFile, dataToSave{:})


