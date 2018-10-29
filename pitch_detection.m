function pitchPeriod = pitch_detection(magR)
% pitch_detection returns pitch from magnitud spectrum
% Format of call: pitch_detection(magR)
% Returns the pitch period in samples
%
% Name: Paulo Esteban Chiliguano Torres
% Date: 2018/10/26
% Revision: 1.0

% Load candidates
load('matfiles/candidatePitch', 'magP');

% Initialise Gain vector
G = zeros(128, 1);

% Calculate Gain
for i = 1:128
    num = (sum(magP(:,i).*magR))^2;
    den = sum(magP(:,i).^2);
    G(i) = num/den;
end

% Maximum gain
[~, I] = max(G);

% Best pitch period
pitchPeriod = I+19;
end