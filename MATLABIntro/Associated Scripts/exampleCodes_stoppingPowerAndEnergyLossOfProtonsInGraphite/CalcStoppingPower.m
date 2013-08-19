%*******************************************************************************
% Title:   CalcStoppingPower.m
% Author:  John Eley
% Date:    15 December 2011
%
% Purpose: Calculate linear stopping power using Bethe-Bloch equation
%
% Notes:   Current version calculates linear stopping power for a proton
%          stopping in graphite.  Ignores shell and density effect corrections.
%
% Input:   Kinetic energy (MeV) of proton
%
% Output:  Stopping power (MeV / cm).  Function returns -1 if proton velocity
%          is below 0.1 * speed of light (Bethe-Bloch theory is not valid)
%*******************************************************************************


function [ stoppingPower ] = CalcStoppingPower( kineticEnergyProton )


    % Projectile properties
    chargeProton = +1; % e


    % Absorber properties (graphite)
    atomicNumberAbsorber = 6;
    atomicMassAbsorber = 12.01; % u
    densityAbsorber = 1.7; % g/cm^3
    meanExcitationPotentialAbsorber = 78.0e-6; % MeV


    % Physical Constants
    pi = 3.1416;
    avogadrosN = 6.0221e+23; % Per mole
    classicalElectronRadius = 2.8179e-13; % cm
    restMassEnergyElectron = 0.5110; % MeV
    restMassEnergyProton = 938.272; % MeV


    % Special Relativity Calculations
    gamma = (kineticEnergyProton + restMassEnergyProton) / restMassEnergyProton; 
    beta = sqrt(1.0 - (1.0 / gamma)^2); % v / c


    % Calculate maximum energy transfer in a single collision - wMax (MeV)
    eta = beta * gamma;
    s = restMassEnergyElectron / restMassEnergyProton;
    wMax = 2.0 * restMassEnergyElectron * eta^2 / ...
            (1.0 + 2.0 * s * sqrt(1.0 + eta^2) + s^2);


    % Compute stopping power (MeV / cm)
    stoppingPower = 2.0 * pi * avogadrosN * classicalElectronRadius^2 * ...
                    restMassEnergyElectron * densityAbsorber * ...
                    (atomicNumberAbsorber / atomicMassAbsorber) * ...
                    (chargeProton / beta)^2 * ...
                    (log(2.0 * restMassEnergyElectron * gamma^2 * ...
                         beta^2 * wMax / meanExcitationPotentialAbsorber^2) - ...
                     2.0 * beta^2);


    % Return -1 if kinetic energy of proton is below the valid range of
    % the Bethe-Bloch equation (i.e., beta < 0.1)
    if (beta < 0.1)
        stoppingPower = -1;
        disp(['< Warning > CalcStoppingPower - ' ...
              'Kinetic energy of proton below valid ' ...
              'range of Bethe-Bloch equation.']);
    end


end

