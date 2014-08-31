function log = analyse_continous_2D(rec)
%ANALYSE_CONTINOUS_2D

log = Logger();

filestr = generate_method_filestr(rec.methodInfo);
methodPlanningProba = proba_normalize_row(rec.(['probabilities_', filestr]));

%distance to goal through iteration
for iStep = 1:rec.nSteps
    
    [~, bestHyp] = max(methodPlanningProba(iStep, :));
    bestPosition = rec.goalHypothesis(bestHyp, :, iStep);
    
    dist = norm(bestPosition - rec.teacherHypothesis(iStep, :), 2);
    log.logit(dist)

end