function w = hybrid_window(~)
% hybrid_window generates a window for pre-processing speech according
% to G.729 standard
% Format of call: hybrid_window()
% Returns a window vector with length 240
% 
% Name: Paulo Esteban Chiliguano Torres
% Date: 2018/10/26
% Revision: 1.0

% Hamming window interval
n = 0:199;
interval1 = 0.54 - 0.46*cos(2*pi*n/399);

% Cosine window interval
n = 200:239;
interval2 = cos(2*pi*(n-200)/159);

% Union of intervals
w = [interval1 interval2];
end