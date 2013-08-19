%*******************************************************************************
% Title:   plotStoppingPowerAndEnergyLoss.m
% Author:  John Eley
% Date:    15 December 2011
%
% Purpose: Plot proton stopping power vs. energy in graphite
%          Plot theoretical Bragg peak for 500 MeV proton in graphite
%
% Notes:   Proton scattering and range straggling ignored.  Only interaction
%          considered is electronic stopping power.  All lost energy is assumed
%          to be deposited locally.
%*******************************************************************************


clear all % Clear variables from MATLAB memory 


%
% Stopping power as function of proton energy
%


% Specify energy range and stepsize for calculations
minProtonEnergy = 10; % MeV
maxProtonEnergy = 1000; % MeV
deltaProtonEnergy = 1; % MeV


% Calculate number of energies corresponding to desired energy range and delta 
nEnergies = floor((maxProtonEnergy - minProtonEnergy) / deltaProtonEnergy) + 1;


% Prepare 1D arrays to store energy and stopping power
energyArray = zeros(nEnergies, 1); % Initialize all array values to zero
stoppingPowerArray = zeros(nEnergies, 1); 


for ii = 1:nEnergies 


    % Determine energy for this counting index (ii)
    energyArray(ii) = minProtonEnergy + (ii - 1) * deltaProtonEnergy;

    % Calculate stopping power (MeV / cm) for this energy, energyArray(ii)
    stoppingPowerArray(ii) = CalcStoppingPower( energyArray(ii) ); % Use my function CalcStoppingPower
    

end


% Plot linear stopping power vs. proton energy in graphite
figure
plot(energyArray, stoppingPowerArray)
xlabel('Proton Kinetic Energy (MeV)')
ylabel('Stopping Power (MeV / cm)')
title('Linear Stopping Power vs. Energy for Proton in Graphite')




%
% Stopping power as a function of depth in graphite
%


initialKineticEnergyProton = 500; % MeV
deltaDepth = 0.01; % cm


kineticEnergyProton = initialKineticEnergyProton; % MeV, Initialize kineticEnergyProton
ii = 1; % Initialize counter


while kineticEnergyProton > 10
    

    depthArray(ii) = ii * deltaDepth; % cm
    stoppingPowerAtDepthArray(ii) = CalcStoppingPower( kineticEnergyProton ); % MeV / cm

    energyLoss = stoppingPowerAtDepthArray(ii) * deltaDepth;
    kineticEnergyProton = kineticEnergyProton - energyLoss; % Subtract energy loss from proton
    ii = ii + 1; % Increment counter


end


% Add remaining proton kinetic energy to final depth to conserve energy
%energyLossArray(ii - 1) = energyLossArray(ii - 1) + kineticEnergyProton;


% Plot stopping power vs. depth
figure
plot(depthArray, stoppingPowerAtDepthArray)
xlabel('Depth (cm)')
ylabel('Stopping Power (MeV / cm)')
title('Proton Stopping Power vs. Depth in Graphite')




% 
% Calculate dose vs. depth (assume all lost energy is deposited locally)
% dose(MeV/g) = fluence(n/cm^2) * stoppingPower(MeV/cm) / density(g/cm^3)
% dose(J/Kg) = dose(MeV/g) * 1.602e-13(J/MeV) * 1000(g/Kg)
%


fluence = 1; % proton / cm^2
densityGraphite = 1.7; % g/cm^3
doseArray = (fluence .* stoppingPowerAtDepthArray ./ densityGraphite) .* ...
            1.602e-13 .* 1000; % Gy


% Add remaining proton kinetic energy to final depth to conserve energy
doseArray(ii - 1) = doseArray(ii - 1) + ...
                    (fluence * kineticEnergyProton / densityGraphite) * ...
                    1.602e-13 .* 1000; % Gy


% Plot dose vs. depth
figure
plot(depthArray, doseArray)
xlabel('Depth (cm)')
ylabel('Dose (Gy)')
title('Dose vs. Depth in Graphite for Single Proton')



