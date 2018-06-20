% uebung_33
clear all; 
close all; 

P = [1 2 2 3 4 4 ; 1 2 4 3 2 4 ]
     

P_mean = mean(P,2)

P_ = P - P_mean 
 
H = P_*P_'

