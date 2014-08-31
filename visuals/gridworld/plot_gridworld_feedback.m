figure('Position', figPositionSquare)
hold on

for i = 1:9 
    idx = 6 - 3*floor((i-1)/3) + mod(i-1,3) + 1;
    subplot(3,3,idx)
    
    scatterpie(rec.teacherSignal(:,1), rec.teacherSignal(:,2), ...
        rec.(rec.hypothesisRecordNames{i}), feedbackColors, feedbackRadius, 'EdgeColor', 'none');
    xlim(feedbackXLim)
    ylim(feedbackYLim)
    axis square
end


figure('Position', figPositionBasic)
subplot(1,2,1)
rec.environment.draw_grid(5)

subplot(1,2,2)
scatterpie(rec.teacherSignal(:,1), rec.teacherSignal(:,2), ...
    rec.plabelHyp1, [niceBlue; niceBlue], feedbackRadius, 'EdgeColor', 'none'); 
xlim(feedbackXLim)
ylim(feedbackYLim)
axis square