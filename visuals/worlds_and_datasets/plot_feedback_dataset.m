%% shuffle random seed according to current time
rec = Logger();
seed = init_random_seed(0); % init seed with current time
rec.log_field('randomSeed', seed);

%%
common

%%
figure('Position', figPositionSquare)

feedbackRadius = 0.15;

X = feedbackDispatcher.X;
Y = ones(2000, 1);
Y(1001:2000) = 2;
pY = label_to_plabel(Y, 1);

scatterpie(X(:,1), X(:,2), pY, feedbackColors, feedbackRadius, 'EdgeColor', 'none');
xlim(feedbackXLim)
ylim(feedbackYLim)
axis square