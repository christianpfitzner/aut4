close all; 
clear all; 

marker = [1 0; 0 0 ; 0 1; 1 1; 1 0]'; 


figure (); 
plot(marker(1,:), marker(2,:), 'o-r', 'MarkerSize', 10)
hold on; 

t = [2 1]'; 
alpha = 45 * pi / 180; 
R = [cos(alpha) -sin(alpha) 0; 
     sin(alpha)  cos(alpha) 0; 
     0           0          1]; 
s = 1.5; 
S = [s 0 0; 
     0 1 0;
     0 0 1]; 
     
v = 0.5; 
V = [1 0 0; 
     v 1 0;
     0 0 0]; 

for i=1:length(marker(1,:))
  pixel = marker(:, i); 

  % apply transformation
  pixel_translation = pixel + t; 
  marker_translation(:, i) = pixel_translation; 
  
  % apply rotation
  pixel_rot        = R * [pixel ; 1]; 
  marker_rot(:, i) = pixel_rot;  
  
  pixel_scale        = S * [pixel ; 1]; 
  marker_scale(:, i) = pixel_scale; 
  
  pixel_shere        = V * [pixel ; 1]; 
  marker_shere(:, i) = pixel_shere; 
end 

%plot(marker_translation(1,:), marker_translation(2,:), 'o-k', 'MarkerSize', 10)
%plot(marker_rot(1,:),         marker_rot(2,:),         'o-b', 'MarkerSize', 10)
%plot(marker_scale(1,:),       marker_scale(2,:),       'o-k', 'MarkerSize', 10)
plot(marker_shere(1,:),       marker_shere(2,:),       'o-k', 'MarkerSize', 10)

axis equal                   # axis square

marker_rot