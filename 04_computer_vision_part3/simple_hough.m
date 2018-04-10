% simple hough transform
clear all; 
close all; 


alpha_step = pi / 20; 
alpha = [-pi*0.5: alpha_step: pi*0.5]

p_1 = [2; 1]; 
p_2 = [4; 2]; 


for i=1:length(alpha)
  d_1(i) = p_1(1) * cos(alpha(i)) + p_1(2)*sin(alpha(i)); 
  d_2(i) = p_2(1) * cos(alpha(i)) + p_2(2)*sin(alpha(i));
end; 



figure(1); 
plot(alpha, d_1); 
hold on; 
plot(alpha, d_2); 



% hough transform
p_size = 100;
m = 3; 
t = 1; 
noise_scale = 20;


% create line with random noise
for i=1:p_size 
  if(i < 50)
    noise_y = rand * noise_scale;
    p(:,i) =  [i; i*m + t*noise_y];
  else
    noise_y = rand * noise_scale;
    p(:,i) =  [i; -i*m - t*noise_y];
  end;
end;

%figure(2); 
%plot(p(1,:), p(2,:), 'xr');

% apply hough transform 
for i=1:p_size
  for a=1:length(alpha)
    d(a, i) = p(1,i) * cos(alpha(a)) + p(2,i) * sin(alpha(a));

  end; 
end; 


%figure(3);
%for i=1:length(p)
%  plot(alpha, d(:,i));
%  hold on; 
%end; 
 
