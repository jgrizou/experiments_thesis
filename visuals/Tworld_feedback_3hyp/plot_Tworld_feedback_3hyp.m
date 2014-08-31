figure('Position', figPositionFullScreen)

subplot(3, 3, 1)
rec.environment.draw_grid(3, 5, 1)

subplot(3, 3, [4, 7])
scatterpie(rec.teacherSignal(:,1), rec.teacherSignal(:,2), ...
    rec.plabelHyp1, feedbackColors, feedbackRadius, 'EdgeColor', 'none');
xlim(feedbackXLim)
ylim(feedbackYLim)
axis square

subplot(3, 3, 2)
rec.environment.draw_grid(3, 5, 7)

subplot(3, 3, [5, 8])
scatterpie(rec.teacherSignal(:,1), rec.teacherSignal(:,2), ...
    rec.plabelHyp2, feedbackColors, feedbackRadius, 'EdgeColor', 'none'); 
xlim(feedbackXLim)
ylim(feedbackYLim)
axis square

subplot(3, 3, 3)
rec.environment.draw_grid(3, 5, 5)

subplot(3, 3, [6, 9])
scatterpie(rec.teacherSignal(:,1), rec.teacherSignal(:,2), ...
    rec.plabelHyp3, feedbackColors, feedbackRadius, 'EdgeColor', 'none'); 
xlim(feedbackXLim)
ylim(feedbackYLim)
axis square