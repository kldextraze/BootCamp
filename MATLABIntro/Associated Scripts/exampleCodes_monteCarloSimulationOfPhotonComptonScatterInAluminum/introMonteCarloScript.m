%********************************************************************************
% Title:   introMonteCarloScript.m
% Author:  John Eley
% Date:    31 January 2012
%
% Purpose: Simulate 100 keV photons undergoing Compton scatter in aluminum
%
% Notes:   
%*******************************************************************************


% Number of photons to simulate
nHistories = 10000;


% Prepare an array to store the distances to first interaction and scatter angles
distanceToFirstInteractionArray = zeros(nHistories, 1);
scatterAngleArray = zeros(nHistories, 1);
energyLossArray = zeros(nHistories, 1);


for iHistory = 1:nHistories

    % Call my function - calcDistanceToInteraction
    distanceToFirstInteractionArray(iHistory) = calcDistanceToInteraction; % cm

    [scatterAngleArray(iHistory) energyLossArray(iHistory)] = calcScatterAngleAndEnergyLoss(10, 82); 

end


% List distances on screen (add semicolon to suppress output)
distanceToFirstInteractionArray;


% Plot distances
figure
hist(distanceToFirstInteractionArray, 100)
xlabel('Distance to First Interaction (cm)')
ylabel('Number of Interactions')

% Plot scatter angles
figure
hist(scatterAngleArray, 100)
xlabel('Scatter Angle (radians)')
ylabel('Number of Photons')

% 










