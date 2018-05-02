% 1d

avg    = 2;
values = 1000; 
noise  = 0.2;  
 
 
for i=1:values; 
  c(i) = avg + (rand-0.5) *2.1; 
end;

plot(c)


% calculate mean error
c_sum = 0; 
for i=1:values
  c_sum = c_sum + c(i); 
end;

c_est_1 = c_sum / values




% recursive least square
c_est_recursive = 0
for i=1:values
  c_est_recursive = c_est_recursive +  (c(i) - c_est_recursive) / i; 
end; 

c_est_recursive






%% 2d example
m = 0.20; 
t = 0.3; 



for i=1:values
  y(i) = m*i + t + rand*noise*10; 
end; 


plot(y)