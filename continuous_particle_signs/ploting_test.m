%%

if strcmp(rec.positionSamplingMethod, 'uncertainty')
    figure
    scatter(rec.teacherHypothesis(end,1),rec.teacherHypothesis(end,2), 'r', 'filled')
    hold on
    scatter(positionToEstimateUncertainty(:,1, end),positionToEstimateUncertainty(:,2,end), 100, positionUncertaintyValues, 'filled')
end


%%

for i = rec.nInitSteps+1:rec.nSteps
    x = 0:0.01:1;
    [X, Y] = meshgrid(x,x);
    Z = pdf(rec.gmd{i}, [X(:), Y(:)]);
    Z = reshape(Z, size(X));
    Z = Z-min(min(Z));
    Z = Z./max(max(Z));
    
    clf
    h = pcolor(X,Y,Z);
    set(h, 'EdgeColor', 'none')
    hold on
    methodPlanningProba = proba_normalize_row(rec.(['probabilities_', filestr])(i-1, :));
%     scatter(rec.goalHypothesis(:,1, i-1),rec.goalHypothesis(:,2, i-1), 100, methodPlanningProba, 'filled')
    scatter(rec.goalHypothesis(:,1, i-1),rec.goalHypothesis(:,2, i-1), 100, 'k')
    scatter(rec.teacherHypothesis(i,1),rec.teacherHypothesis(i,2), 'r', 'filled')
    drawnow
    pause
end


    
%% plot
clf

filestr = generate_method_filestr(methodInfo);
methodPlanningProba = proba_normalize_row(rec.(['probabilities_', filestr])(end, :));
scatter(rec.position(:,1), rec.position(:,2), 30, 'g')
hold on
scatter(rec.goalHypothesis(:,1, end),rec.goalHypothesis(:,2,end), 100, methodPlanningProba, 'filled')
scatter(rec.teacherHypothesis(end,1),rec.teacherHypothesis(end,2), 'r', 'filled')

xlim([0, 1])
ylim([0, 1])

drawnow