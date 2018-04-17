clear all;
close all;

% gerate noisy data

% noise x
noise_x = 0.0; 
noise_y = 2.0; 

nr_points   = 100; 
nr_outliers = 100;


% calculate number of trials
p = 0.99; 
e = 0.5; 
optimal_trials = log(1-p) / (log(1 - (1 - e)^2))



trials = optimal_trials; 

% line g = m*x +t 
t = 5.0; 
m = 0.3; 
g = ones(1,nr_points); 
for n = 1:nr_points
  outlier = 0; 
  if(mod(n, 2) == 0)
    outlier=20*(rand-0.5); 
  end; 
  
  g(n) = m * n  + t+(rand-0.5)*noise_y + outlier; 
end

x =1:nr_points;
hold on; 
plot(x,g, '+'); 


model_m_best = 1; 
model_t_best = 1; 
d_best = 100000; 
for t=1:trials
 
  % 1. step: select random points
  p1_idx = randi(nr_points);
  p2_idx = randi(nr_points); 

  p1 = ones(1,2); 
  p2 = ones(1,2); 

  p1(1) = x(p1_idx); 
  p1(2) = g(p1_idx); 

  p2(1) = x(p2_idx); 
  p2(2) = g(p2_idx); 
 

  % 2. step: calculate model for points
  model_m = (p2(2) - p1(2)) / (p2(1) - p1(1)); 
  model_t =  p2(2) - (model_m*p2(1)); 



  % 3. step: calculate distance to model for all points
  d = ones(1,nr_points); 
  M = ones(2,100); 
  inliers = 1; 
  for(n=1:nr_points)
    y_model = model_m * n  + model_t; 
    y_point = g(n);
    d(n) = abs(y_model - y_point); 
    if(d(n) < 1.4)
      M(1,inliers) = n; 
      M(2,inliers) = g(n);
     inliers = inliers + 1;  
      x =1:nr_points; 
      x_best = model_m*x + model_t; 
    endif
  end


  if(t==10)
    csvwrite('/tmp/02_inliers.csv', M'); 
    csvwrite('/tmp/02_model.csv', x_best');   
  endif
  


  % 4. step: count numbers of inliers based on threshold
  
  if(sum(d) < d_best)
    model_m_best = model_m;  
    model_t_best = model_t;
    d_best       = sum(d);
  end
  
end





    model_m_best 
    model_t_best 
    d_best       

n =1:nr_points; 
g_best = model_m_best*n + model_t_best; 
plot(n, g_best, 'r'); 


csvwrite('/tmp/ransac_model_line.csv', g_best'); 

csvwrite('/tmp/ransac_data.csv', g'); 
