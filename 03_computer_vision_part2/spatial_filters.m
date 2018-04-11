%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Examplws for spacial filters with kernels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Christian Pfitzner
% Lecture: AUT4 B
% Affiliation: Technische Hochschule Nürnberg
%               Georg Simon Ohm
% License: MIT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clean up history
clear all; 
close all; 


% show input image
figure(1); 
[img, map] = imread ("../resources/lenna_sw.png");     % load image
imshow(img);                                        % show image




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% examples from lecture
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I1 = [10, 10, 10, 10, 10; 
      10, 10, 15, 20, 20; 
      100, 100, 100, 100, 100; 
      255, 255, 255, 255, 255; 
      255, 255, 255, 255, 255]; 
      
% example for edge detection
I2 = [10, 10, 10, 10, 10; 
      10, 10, 10, 10, 10; 
      10, 10, 10, 10, 10; 
      255, 255, 255, 255, 255; 
      255, 255, 255, 255, 255]; 
      
      
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Identity Kernel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
K0 = [0 0 0
      0 1 0
      0 0 0];  

 identity = conv2(K0 , I1); 
      
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Smoothing Kernel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

% Box Blur
K1 = [1/9, 1/9, 1/9 ; 
     1/9, 1/9, 1/9 ; 
     1/9, 1/9, 1/9 ]; 
K25 = 1/25 .*ones(5,5); 
output = conv2(K25, img); 



% Gaussian Blurring (Size 3)
G3 = 1/16 * [1  2  1; 
             2  4  2; 
             1  2  1]; 
    
% Gaussian Blurring (Size 5)
G5 = 1/256 * [1  4  6  4  1; 
             4 16 24  16 4; 
             6 24 36  24 6; 
             4 16 24  16 4;
             1  4  6  4  1]; 
             
             

             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sharpend
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S = [0 -1 0; 
     -1 5 -1; 
     0 -1 0];      
%output = conv2(S, img);     
    
    
E1 = [1 0 -1; 
      0 0  0; 
      1 0  1]; 
%output = conv2(E1, img);       
      
E2 = [-1 -1 -1; 
      -1  8 -1; 
      -1 -1 -1];     

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% edge detection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% sobel operator
Sx = [1 0 -1; 
      2 0 -2; 
      1 0 -1]; 
Sy = Sx'; 
output = conv2(Sy, img); 

     
figure(2);      
imshow(uint8(output)); 
  
  
% Difference of Gaussian (DOG)
blurred  = conv2(G3, img); 
blurred  = (blurred(2:end-1, 2:end-1)); 
blurred2 = conv2(G5, blurred); 
blurred2 = (blurred2(2:end-3, 2:end-3)); 

%output = img - blurred2; 

  


  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




