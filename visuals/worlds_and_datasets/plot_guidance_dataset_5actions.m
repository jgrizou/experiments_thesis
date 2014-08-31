%% shuffle random seed according to current time
rec = Logger();
seed = init_random_seed(3); % init seed with current time
rec.log_field('randomSeed', seed);

%%
common

%%
figure('Position', figPositionSquare)

guidanceRadius = 0.2;

X = guidanceDispatcher.X;
Y = ones(4000, 1);
Y(1001:2000) = 2;
Y(2001:3000) = 3;
Y(3001:4000) = 4;
Y(4001:5000) = 5;
pY = label_to_plabel(Y, 1);

scatterpie(X(:,1), X(:,2), pY, guidanceColors, guidanceRadius, 'EdgeColor', 'none');
xlim(guidanceXLim)
ylim(guidanceYLim)
axis square