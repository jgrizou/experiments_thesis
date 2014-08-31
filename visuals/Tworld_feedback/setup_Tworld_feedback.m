%% Environement
% set-up world
nA = 4;
environment = Discrete_mdp_Tworld(nA);
environment.set_state(3);
rec.logit(environment)

% generate task hypothesis
% hytothesis are represented as optimal policies
nHypothesis = 2;
nStates = environment.nS;
hypothesisPolicies = cell(1, nHypothesis);
for iHyp = 1:nHypothesis
    tmpEnvironment = Discrete_mdp_Tworld(nA);
    tmpR = zeros(nStates, 1);
    if iHyp == 1
        tmpR(1) = 1; % sparse reward function
    elseif iHyp == 2
        tmpR(5) = 1; % sparse reward function
    end
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