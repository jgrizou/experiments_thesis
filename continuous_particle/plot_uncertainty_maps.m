function plot_uncertainty_maps(resultFolder, xp)

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


load('/Users/jgrizou/Dropbox/code/experiments/continuous_particle/analysis/uncertainty_active_50.mat')

filename = log.fileName{xp};
[~, fname, ext] = fileparts(filename);

rfn = fullfile(resultFolder, 'uncertainty', 'active', '50', [fname, ext]);
load(rfn)

figure('Position', figPositionThreeSquare)
subplot(1,2,1)
hold on
plot(log.dist(:, xp), 'color', niceOrange, 'linewidth', 2)
xlabel('Iterations')
ylabel('Distance to goal')
xlim([0,200])
ylim([0,0.4])

subplot(1,2,2)
hold on
scatter(rec.teacherHypothesis(:,1), rec.teacherHypothesis(:,2), dotGoalSize, niceRed, 'filled')
xlabel('X')
ylabel('Y')
title('Goal state')
xlim([0,1])
ylim([0,1])
axis square

figure('Position', figPositionThreeSquare)
hold on
for i = 1:nSteps
    subplot(1,nSteps,i)
    hold on

%     mappedColors = values_to_colors(rec.positionUncertaintyValues(steps(i),:));
    mappedColors = rec.positionUncertaintyValues(steps(i),:);
    scatter(rec.positionToEstimateUncertainty(:,1, steps(i)), rec.positionToEstimateUncertainty(:,2, steps(i)), dotSize, mappedColors, 'filled')

    xlabel('X')
    ylabel('Y')
    title(['Uncertainty ', num2str(steps(i)), ' steps'])


    xlim([0,1])
    ylim([0,1])
    axis square

end

%%
figure('Position', figPositionThreeSquare)
hold on
for i = 1:nSteps
    subplot(1,nSteps,i)
    hold on
    
    proba = rec.probabilities_online_sampling_simple_matching_batch_normal(steps(i),:);
    proba = proba_normalize_row(proba);
    mappedColors = values_to_colors(proba);
    scatter(rec.goalHypothesis(end:-1:1,1, steps(i)), rec.goalHypothesis(end:-1:1,2, steps(i)), dotGoalSize, mappedColors(end:-1:1,:), 'filled')

    xlabel('X')
    ylabel('Y')
    title(['Weights ', num2str(steps(i)), ' steps'])


    xlim([0,1])
    ylim([0,1])
    axis square

end