[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
analysisFolder = fullfile(pathstr, 'analysis');


load(fullfile(analysisFolder, 'feedback'))
probaFeedback = log.pairwiseProbaEvolution;

load(fullfile(analysisFolder, 'guidance'))
probaGuidance = log.pairwiseProbaEvolution;

proba = [probaFeedback, probaGuidance];
stats = prctile(proba,[25, 50, 75],2);

%%
startid = 1;
stepsize = 5;
endid = 200;

proba = proba(startid:stepsize:endid,:);
stats = stats(startid:stepsize:endid,:);

probaFeedback = probaFeedback(startid:stepsize:endid,:);
probaGuidance = probaGuidance(startid:stepsize:endid,:);


%%

meamproba = mean(proba,2);
steproba = std(proba, 0, 2)/sqrt(size(proba, 2));

meamprobaFeedback = mean(probaFeedback,2);
steprobaFeedback = std(probaFeedback, 0, 2)/sqrt(size(probaFeedback, 2));

meamprobaGuidance = mean(probaGuidance,2);
steprobaGuidance = std(probaGuidance, 0, 2)/sqrt(size(probaGuidance, 2));

%%
figure()

hold on
plot([0, 200], [1, 1], 'k--')
errorbar(startid:stepsize:endid, meamproba, steproba, 'r', 'linewidth', 1)

xlim([0, 200])
ylim([0, 1.05])

xlabel('Iterations')
ylabel('Min pairwise normalized likelihood')

%%
figure()

hold on
plot([0, 200], [1, 1], 'k--')
errorbar(startid:stepsize:endid, meamprobaFeedback, steprobaFeedback, 'g')

xlim([0, 200])
ylim([0, 1.05])

xlabel('Iterations')
ylabel('Min pairwise normalized likelihood')


%%
figure()

hold on
plot([0, 200], [1, 1], 'k--')
errorbar(startid:stepsize:endid, meamprobaGuidance, steprobaGuidance, 'b')

xlim([0, 200])
ylim([0, 1.05])

xlabel('Iterations')
ylabel('Min pairwise normalized likelihood')






