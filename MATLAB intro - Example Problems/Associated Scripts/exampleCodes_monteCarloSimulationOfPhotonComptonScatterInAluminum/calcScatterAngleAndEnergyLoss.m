function [dScatterAngle, dEnergyLost] = ...
    calcScatterAngleAndEnergyLoss( dKineticEnergyPhoton, ... % MeV
                                   iAtomicNumber ... % Atomic number (Z) of scattering material
                                 )


    %********************************************************************************
    % Title:   calcScatterAngleAndEnergyLoss.m
    % Author:  John Eley
    % Date:    31 January 2012
    %
    % Purpose: Calculate randomly sampled Compton scatter angle and energy lost
    %
    % Inputs:  dKineticEnergyPhoton = kinetic energy of photon undergoing scatter (MeV) 
    %          iAtomicNumber = atomic number of scattering material
    %
    % Output:  dScatterAngle = scatter angle of photon (radians) 
    %          dEnergyLost = energy (MeV) lost by the photon in the interaction
    %
    % Notes:   
    %*******************************************************************************


    % Klein-Nishina Angular Scattering Cross Section
    dClassicalElectronRadius = 2.817e-13; % cm
    dAlpha = dKineticEnergyPhoton / 0.511;




    % Find max value of Klein-Nishina for dTheta in 0 to pi
    dMax = 0;
    for iTheta = 0:pi/1000:pi
        dTheta = iTheta; % radians

        dKleinNishinaAngularCrossSection = ...
            iAtomicNumber * dClassicalElectronRadius^2 * ...
            (1 / (1 + dAlpha * (1 - cos(dTheta))))^2 * ...
            ((1 + cos(dTheta)^2) / 2) * ...
            (1 + (dAlpha^2 * (1 - cos(dTheta))^2) / ...
                 ((1 + cos(dTheta)^2) * (1 + dAlpha * (1 - cos(dTheta))))); % cm^2 / steradian

        if (dKleinNishinaAngularCrossSection > dMax)
            dMax = dKleinNishinaAngularCrossSection;
        end

    end




    % Rejection Method
    iAcceptTheta = 0;
    while (iAcceptTheta ~= 1)

        % Generate a random number
        dRandomNumber = rand(1); % Generate 1 random number between 0 and 1

        % Assign a first dTheta value
        dTheta = 0 + dRandomNumber * (pi - 0);

        % Generate a 2nd random number
        dRandomNumber2 = rand(1); 

        % Evaluate Klein-Nishina at dTheta
        dKleinNishinaAngularCrossSection = ...
            iAtomicNumber * dClassicalElectronRadius^2 * ...
            (1 / (1 + dAlpha * (1 - cos(dTheta))))^2 * ...
            ((1 + cos(dTheta)^2) / 2) * ...
            (1 + (dAlpha^2 * (1 - cos(dTheta))^2) / ...
                 ((1 + cos(dTheta)^2) * (1 + dAlpha * (1 - cos(dTheta))))); % cm^2 / steradian

        % Test rejection criteria
        if (dRandomNumber2 * dMax <= dKleinNishinaAngularCrossSection)
            iAcceptTheta = 1;
        end

    end 
    
    % Accept theta
    dScatterAngle = dTheta;




    % Compton equation for energy loss
    dEnergyLost = dKineticEnergyPhoton - ...
                  (dKineticEnergyPhoton) / (1 + (dKineticEnergyPhoton / 0.511) * ...
                                                (1 - cos(dScatterAngle))); % MeV
                                        



end % END calcDistanceToInteraction