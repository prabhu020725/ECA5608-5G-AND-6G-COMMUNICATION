
% Comparison of FDMA, TDMA and CDMA
% Simplified illustrative model
% Not a full cellular-network simulation

clear;
clc;
close all;

%% 1. Define System Parameters

totalBandwidthHz = 1e6;    % Total bandwidth: 1 MHz
fdmaChannelHz = 200e3;     % FDMA channel width: 200 kHz
tdmaSlots = 8;             % Number of TDMA slots per frame
processingGain = 64;       % CDMA processing gain
targetSIRdB = 7;           % Minimum acceptable CDMA SIR in dB

%% 2. Calculate Estimated User Capacity

fdmaUsers = floor(totalBandwidthHz / fdmaChannelHz);
tdmaUsers = tdmaSlots;

targetSIR = 10^(targetSIRdB / 10);

cdmaUsers = floor(1 + processingGain / targetSIR);

%% 3. Display Maximum Supported Users

fprintf('Illustrative maximum supported users\n');
fprintf('FDMA: %d users\n', fdmaUsers);
fprintf('TDMA: %d users\n', tdmaUsers);
fprintf('CDMA: %d users at a target SIR of %.1f dB\n\n', ...
    cdmaUsers, targetSIRdB);

%% 4. Calculate CDMA SIR for Different User Counts

K = 2:30;

sirLinear = processingGain ./ (K - 1);
sirDb = 10 * log10(sirLinear);

%% 5. Create a Comparison Table

method = ["FDMA"; "TDMA"; "CDMA"];

supportedUsers = [fdmaUsers; tdmaUsers; cdmaUsers];

results = table(method, supportedUsers);

disp(results);

%% 6. Plot User Capacity Comparison

figure;

bar(categorical(method), supportedUsers);

ylabel('Illustrative maximum supported simultaneous users');
title('FDMA, TDMA and CDMA: Capacity Estimate');

grid on;

%% 7. Plot CDMA SIR versus Number of Users

figure;

plot(K, sirDb, 'o-', 'LineWidth', 1.5);

hold on;

yline(targetSIRdB, '--r', 'Target SIR');

xlabel('Number of simultaneous CDMA users (K)');
ylabel('Estimated SIR (dB)');

title('Estimated CDMA SIR versus Number of Users');

grid on;

hold off;
