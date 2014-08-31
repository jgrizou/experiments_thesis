function log = analysis_multiple_frame_guidance(rec)

log = Logger();

filestr = generate_method_filestr(rec.methodInfo);
methodPlanningProba = rec.(['probabilities_', filestr]);

bestHyp = rec.teacherHypothesis(end) + rec.nHypothesis/rec.nFrames;
pairwiseProbaEvolution = methodPlanningProba(:, bestHyp);

log.logit(pairwiseProbaEvolution)
