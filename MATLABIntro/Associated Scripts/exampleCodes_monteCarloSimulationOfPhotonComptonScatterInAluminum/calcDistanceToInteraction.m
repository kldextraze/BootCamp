function [dDistanceToInteraction] = calcDistanceToInteraction( )


    %********************************************************************************
    % Title:   calcDistanceToInteraction.m
    % Author:  John Eley
    % Date:    31 January 2012
    %
    % Purpose: Calculate randomly-sampled distance to first interaction for a 100 keV photon
    %          in aluminum
    %
    % Input:   None at this time
    %
    % Output:  dDistanceToInteraction = distance to first interaction in cm
    %
    % Notes:   
    %*******************************************************************************


    dLinearAttenuationCoefficient = 0.462; % cm^-1, 100 keV photon, Al

    dRandomNumber = rand(1); % Generate 1 random number between 0 and 1

    dDistanceToInteraction = -1.0 * log(1 - dRandomNumber) / dLinearAttenuationCoefficient;


end % END calcDistanceToInteraction