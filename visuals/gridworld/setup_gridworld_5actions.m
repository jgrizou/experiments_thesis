%% Environement
% set-up world
nA = 5;
gSize = 3;
environment = Discrete_mdp_gridworld(gSize, nA);
environment.set_state(5);
rec.logit(environment)

% generate task hypothesis
% hytothesis are represented as optimal policies
nStates = environment.nS;
nHypothesis = environment.nS;
hypothesisPolicies = cell(1, nHypothesis);
for iHyp = 1:nHypothesis
    tmpEnvironment = Discrete_mdp_gridworld(gSize, nA);
    tmpR = zeros(nStates, 1);
    tmpR(iHyp) = 1;
    tmpEnvironment.set_reward(tmpR);
    [~, hypothesisPolicies{iHyp}] = VI(tmpEnvironment);
end
rec.logit(nHypothesis)
rec.logit(hypothesisPolicies)

hypothesisRecordNames = cell(1, rec.nHypothesis);
for iHyp = 1:rec.nHypothesis
    hypothesisRecordNames{iHyp} = ['plabelHyp', num2str(iHyp)];
end
rec.logit(hypothesisRecordNames)