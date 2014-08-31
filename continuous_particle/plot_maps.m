clean
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));

analysisFolder = fullfile(pathstr, 'analysis');
resultFolder = fullfile(pathstr, 'results');

%% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Courier')
DefaultAxesFontSize = 25;
set(0,'DefaultAxesFontSize', DefaultAxesFontSize)
set(0,'DefaultAxesFontWeight','bold')
set(0,'DefaultAxesLineWidth', 2.5)

niceBlue = [0.2, 0.4, 0.8];
niceGreen = [0.4, 0.8, 0.2];
niceGray = [0.2, 0.2, 0.2];
niceOrange = [0.9, 0.5, 0];
niceRed = [1, 0.2, 0.2];

figPosition = [200, 300, 800, 700];
figPositionThreeSquare = [1, 323, 1280, 383];


dotSize = 50;
dotGoalSize = 100;

steps = [15, 50, 150];
nSteps = length(steps);

%%

load('/Users/jgrizou/Dropbox/code/experiments/continuous_particle/results/random/random/50/00_06_36_850_11_June_2014.mat')

figure('Position', figPosition)
hold on

scatter(rec.position(:,1), rec.position(:,2), dotSize, niceBlue, 'filled')
scatter(rec.teacherHypothesis(:,1), rec.teacherHypothesis(:,2), dotGoalSize, niceRed, 'filled')

xlabel('X')
ylabel('Y')
title('Visited states')

xlim([0,1])
ylim([0,1])
axis square

%%

load('/Users/jgrizou/Dropbox/code/experiments/continuous_particle/results/uncertainty/active/50/01_18_26_340_12_June_2014.mat')

figure('Position', figPosition)
hold on

scatter(rec.position(:,1), rec.position(:,2), dotSize, niceBlue, 'filled')
scatter(rec.teacherHypothesis(:,1), rec.teacherHypothesis(:,2), dotGoalSize, niceRed, 'filled')

xlabel('X')
ylabel('Y')
title('Visited states')


xlim([0,1])
ylim([0,1])
axis square

%%

load('/Users/jgrizou/Dropbox/code/experiments/continuous_particle/results/uncertainty/random/50/08_32_23_931_10_June_2014.mat')


figure('Position', figPositionThreeSquare)
hold on
for i = 1:nSteps
    subplot(1,nSteps,i)
    hold on
    
    scatter(rec.goalHypothesis(:,1,steps(i)), rec.goalHypothesis(:,2,steps(i)), dotSize, niceBlue, 'filled')
    scatter(rec.teacherHypothesis(:,1), rec.teacherHypothesis(:,2), dotGoalSize, niceRed, 'filled')
    
    xlabel('X')
    ylabel('Y')
    title(['After ', num2str(steps(i)), ' steps'])
    
    xlim([0,1])
    ylim([0,1])
    axis square
end

%%

load('/Users/jgrizou/Dropbox/code/experiments/continuous_particle/results/uncertainty/active/50/07_35_39_000_11_June_2014.mat')

figure('Position', figPositionThreeSquare)
hold on
    
for i = 1:length(steps)
    subplot(1,nSteps,i)
    hold on
    
    scatter(rec.goalHypothesis(:,1,steps(i)), rec.goalHypothesis(:,2,steps(i)), dotSize, niceBlue, 'filled')
    scatter(rec.teacherHypothesis(:,1), rec.teacherHypothesis(:,2), dotGoalSize, niceRed, 'filled')
    
    xlabel('X')
    ylabel('Y')
    title(['After ', num2str(steps(i)), ' steps'])
    
    xlim([0,1])
    ylim([0,1])
    axis square
end

%%
%17, 18, 38, 43, 60, 71, 83

%%
plot_uncertainty_maps(resultFolder, 17)

%%
plot_uncertainty_maps(resultFolder, 18)







