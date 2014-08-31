clean

%% plot option

% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Courier')
DefaultAxesFontSize = 25;
set(0,'DefaultAxesFontSize', DefaultAxesFontSize)
set(0,'DefaultAxesFontWeight','bold')
set(0,'DefaultAxesLineWidth', 2.5)

figPositionBasic = [0, 0, 800, 500];
figPositionFullScreen = [0, 0, 1200, 500];
figPositionSquare = [0, 0, 600, 600];
figPositionWide = [0, 350, 1200, 350];

niceGreen = [0.4, 0.8, 0.2]; % green
niceRed = [1, 0.2, 0.2]; % red
niceBlue = [0.2, 0.4, 0.8]; % 
niceOrange = [0.9, 0.5, 0]; %
niceBlack = [0.07, 0.06, 0.2]; % black
nicePurple = [0.6, 0.07, 0.86]; % purple
niceGray = [0.5, 0.5, 0.5]; %clear grey

colors = [niceBlue; niceOrange; niceGreen; niceRed; nicePurple];

%%
step = 1e-3;
x = 0:step:1;

figure('Position', [0, 0, 700, 800])
hold on
y = [];
cnt = 0;
for i = [1,2,5,10,100]
    cnt = cnt + 1;
    y(:, cnt) = genlikelihood(x, i);
    
    plot(x, y(:, cnt), 'color', colors(cnt, :),  'linewidth', 2)

end
h = legend(' nSA = 1', ' nSA = 2', ' nSA = 5', ' nSA = 10', ' nSA = 100', 'Location', 'BO');
set(h, 'Box', 'off')
rect = [0.4, 0.65, .25, .25];
set(h, 'Position', rect)

xlim([-0.01,1.01])
ylim([0,1.01])

xlabel('\Upsilon')
ylabel('Likelihood')


%%
figure('Position', [0, 0, 700, 800])
hold on

plot(x, y(:,1), 'color', niceBlue, 'linewidth', 2)

h = legend(' nSA = 1');
set(h, 'Box', 'off')
rect = [0.4, 0.775, .25, .25];
set(h, 'Position', rect)


xlim([-0.01,1.01])
ylim([0,1.01])

xlabel('\Upsilon')
ylabel('Likelihood')

%%
figure('Position', [0, 0, 700, 800])
hold on

y = - (x.*log2(x) + (1-x).*log2(1-x));

plot(x, y, 'color', niceBlue, 'linewidth', 2)

xlim([-0.01,1.01])
ylim([0,1.01])

xlabel('\Upsilon')
ylabel('Entropy')

%%

