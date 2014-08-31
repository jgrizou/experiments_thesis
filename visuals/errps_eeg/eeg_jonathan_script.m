clean
common
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
load(fullfile(pathstr, 'eeg_jonathan.mat'))

%%

%4
%20

init_random_seed(20)

nSample = 50;
xlimit = [0, 1000];
ylimit = [-40, 60];

idx = randsample(length(eeg.idx_correct), nSample);
eeg_correct =  eeg.data(eeg.idx_correct(idx), :);
idx = randsample(length(eeg.idx_error), nSample);
eeg_error = eeg.data(eeg.idx_error(idx),:);

%%
figure('Position', figPositionSquare)
hold on
% grid on

plot([250 250], ylimit, 'k--', 'LineWidth', 1);
plot([500 500], ylimit, 'k--', 'LineWidth', 1);
plot([750 750], ylimit, 'k--', 'LineWidth', 1);
plot(xlimit, [-20 -20], 'k--', 'LineWidth', 1);
plot(xlimit, [0 0], 'k--', 'LineWidth', 1);
plot(xlimit, [20 20], 'k--', 'LineWidth', 1);
plot(xlimit, [40 40], 'k--', 'LineWidth', 1);

h1 = plot(eeg.time_range, mean(eeg_correct,1), 'color', niceGreen, 'LineWidth', 3);
h2 = plot(eeg.time_range, mean(eeg_error,1), 'r', 'LineWidth', 3);
% plot([0 0], [-20 20], 'm', 'LineWidth', 2);
xlim(xlimit)
ylim(ylimit)
set(gca,'XTick', 0:250:1000)
% set(gca,'XTickLabel', 0:100:1000, )

xlabel('Time (ms)')
ylabel('Voltage (\muV)')

legend([h1, h2], ' Correct', ' Incorrect')
% legend('boxoff')

%%
figure('Position', figPositionSquare)
hold on 
% grid on

plot([250 250], ylimit, 'k--', 'LineWidth', 1);
plot([500 500], ylimit, 'k--', 'LineWidth', 1);
plot([750 750], ylimit, 'k--', 'LineWidth', 1);
plot(xlimit, [-20 -20], 'k--', 'LineWidth', 1);
plot(xlimit, [0 0], 'k--', 'LineWidth', 1);
plot(xlimit, [20 20], 'k--', 'LineWidth', 1);
plot(xlimit, [40 40], 'k--', 'LineWidth', 1);

plot(eeg.time_range, eeg_correct, 'color', niceGray, 'LineWidth', 0.5);
plot(eeg.time_range, mean(eeg_correct,1), 'color', niceGreen, 'LineWidth', 3);
% plot([0 0], [-20 20], 'm', 'LineWidth', 2);
xlim(xlimit)
ylim(ylimit)
set(gca,'XTick', 0:250:1000)
% set(gca,'XTickLabel', 0:100:1000, )

xlabel('Time (ms)')
ylabel('Voltage (\muV)')


%%
figure('Position', figPositionSquare)
hold on 
% grid on

plot([250 250], ylimit, 'k--', 'LineWidth', 1);
plot([500 500], ylimit, 'k--', 'LineWidth', 1);
plot([750 750], ylimit, 'k--', 'LineWidth', 1);
plot(xlimit, [-20 -20], 'k--', 'LineWidth', 1);
plot(xlimit, [0 0], 'k--', 'LineWidth', 1);
plot(xlimit, [20 20], 'k--', 'LineWidth', 1);
plot(xlimit, [40 40], 'k--', 'LineWidth', 1);

plot(eeg.time_range, eeg_error, 'color', niceGray, 'LineWidth', 0.5); 
plot(eeg.time_range, mean(eeg_error,1), 'color', niceRed, 'LineWidth', 3);
% plot([0 0], [-20 20], 'm', 'LineWidth', 2);
xlim(xlimit)
ylim(ylimit)
set(gca,'XTick', 0:250:1000)
% set(gca,'XTickLabel', 0:100:1000, )

xlabel('Time (ms)')
ylabel('Voltage (\muV)')