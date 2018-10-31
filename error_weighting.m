function a_w = error_weighting(a, gamma)
% error_weighting computes error weighting filter coefficients
% Format of call: error_weighting(a, gamma)
% Returns a vector of filter coefficients considering weighting factors
%
% Name: Paulo Esteban Chiliguano Torres
% Date: 2018/10/29
% Revision: 1.0

% weighting factors initialisation
a_w = zeros(length(a), 1);

% generate weighting factors
for i = 1:length(a)
    a_w(i) = a(i).*gamma^(i-1);
end
end