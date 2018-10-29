% This script generates the magnitude spectrum of candidate
% pitch-related excitation
% Number of samples
n = 1:160;
% Initialise matrix of candidates
p = zeros(160, 128);
% Sampling frequency
Fs = 8000;
% Size of STFT
M = 512;
% Fourier transform pair
for pitchPeriod = 20:147
    for m = 0:512
        aux = cos(m*n*1/Fs*2*pi*Fs/pitchPeriod);
        p(:, pitchPeriod-19) = p(:, pitchPeriod-19) + aux';
    end
    p(:, pitchPeriod-19) = p(:, pitchPeriod-19)/(M+1);
end
% 512-point FFT
P = fft(p,M);
% Magnitude up to 1 kHz (pi/4)
magP = abs(P(1:65,:));
% Save the magnitude spectrum of candidates for future use
save('matfiles/candidatePitch','magP');