function w = bandwidth_expansion(k)
% bandwidth_expansion generates a window for autocorrelation coefficients
% Format of call: bandwidth_expansion(k)
% Returns a window vector with length k
% 
% Name: Paulo Esteban Chiliguano Torres
% Date: 2018/10/26
% Revision: 1.0

% Expansion frequency
fo = 60;

% White-noise factor
whiteNoiseFactor = 1.001;

% Expansion window
w = [whiteNoiseFactor exp(-0.5*(2*pi*fo*(1:k-1)/8000).^2)];
end