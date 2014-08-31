function log = analysis_multiple_frame_feedback(rec)

log = Logger();

filestr = generate_method_filestr(rec.methodInfo);
methodPlanningProba = rec.(['probabilities_', filestr]);

bestHyp = rec.teacherHypothesis(end);
pairwiseProbaEvolution = methodPlanningProba(:, bestHyp);

log.logit(pairwiseProbaEvolution)
