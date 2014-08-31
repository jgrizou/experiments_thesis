figure('Position', figPositionBasic)

subplot(3,2,1)
rec.environment.draw_grid(3, 5, 1)

subplot(3,2,[3,5])
scatterpie(rec.teacherSignal(:,1), rec.teacherSignal(:,2), ...
    rec.plabelHyp1, guidanceLineColors, guidanceLineRadius, 'EdgeColor', 'none');
xlim(guidanceLineXLim)
ylim(guidanceLineYLim)
axis square

subplot(3,2,2)
rec.environment.draw_grid(3, 5, 5)

subplot(3,2,[4,6])
scatterpie(rec.teacherSignal(:,1), rec.teacherSignal(:,2), ...
    rec.plabelHyp2, guidanceLineColors, guidanceLineRadius, 'EdgeColor', 'none'); 
xlim(guidanceLineXLim)
ylim(guidanceLineYLim)
axis square