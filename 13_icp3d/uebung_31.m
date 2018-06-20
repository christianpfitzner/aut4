% Übung 31

D = [1 2 2; 1 0 2]
M = [1 2 0; 1 2 2] 






% calculate centroids
D_mean = mean(D, 2)
M_mean = mean(M, 2)


% calculate centered model and scene
D_ = D - D_mean 
M_ = M - M_mean

% calculate covariance matrix H
H = D_ * M_'




%% alternative
cov(D)
