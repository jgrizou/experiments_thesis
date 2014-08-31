%% shuffle random seed according to current time
seed = init_random_seed(0); % init seed with current time
common

%%
nPoint = 20;
cst = 0.8;
X1 = rand(nPoint,1);
X2 = rand(nPoint,1) + cst;

X1 = X1 / 2;
X2 = X2 / 2; 

meanX1 = mean(X1)
stdX1 = std(X1)

meanX2 = mean(X2)
stdX2 = std(X2)

meanDiff = meanX2 - meanX1
stdDiff = sqrt(stdX1.^2 + stdX2.^2)

%% 

step = 1e-3;
x = -0.2:step:1;

pdfX1 =  normpdf(x, meanX1, stdX1);
pdfX2 =  normpdf(x, meanX2, stdX2);
pdfDiff =  normpdf(x, meanDiff, stdDiff);
cdfDiff = normcdf(x, meanDiff, stdDiff);


%%
lw = 2;
pointSize = 100;

figure('Position', figPositionWide)
hold on

colors = [niceBlue; niceOrange];
scatter(X1, ones(nPoint, 1)*3.4, pointSize, colors(1, :), 'filled'); 
plot(x, pdfX1, 'color', colors(1, :), 'linewidth', lw)

scatter(X2, ones(nPoint, 1)*4.3, pointSize, colors(2, :), 'filled'); 
plot(x, pdfX2, 'color', colors(2, :), 'linewidth', lw)

xlim([-0.2, 1])
ylim([0, 4.5])

%%
figure('Position', figPositionWide)
hold on

plot(x, pdfDiff, 'color', niceRed, 'linewidth', lw)

xlim([-0.2, 1])
ylim([0, 4.5])

%%
figure('Position', figPositionWide)
hold on

plot(x, cdfDiff, 'color', niceRed, 'linewidth', lw)

xlim([-0.2, 1])
ylim([0, 1.01])

%%

normcdf(0, meanDiff, stdDiff)
1 - normcdf(0, meanDiff, stdDiff)


