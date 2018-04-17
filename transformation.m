 ## Various linear transforms
 figure (); 
 im = [checkerboard(20, 2, 4); checkerboard(40, 1, 2)];
 %input space corners
 incp = [1 1; 160 1; 160 160; 1 160];
 udata = [min(incp(:,1)) max(incp(:,1))];
 vdata = [min(incp(:,2)) max(incp(:,2))];
 subplot (2,3,1); 
 imshow (im)
 hold on
 plot (incp(:,1), incp(:,2), 'ob')
 axis on
 xlabel ('Original')
 
 % Translation and scaling
 outcp = incp * 2;
 outcp(:,1) += 200; 
 outcp(:,2) += 500;
 T = maketform ('affine', incp(1:3,:), outcp(1:3,:));
 subplot (2,3,2); 
 [im2 xdata ydata] = imtransform (im, T, 'udata', udata,
                                  'vdata', vdata, 'fillvalues', 1);
 imh = imshow (im2); set (imh, 'xdata', xdata, 'ydata', ydata) 
 set (gca, 'xlim', xdata, 'ylim', ydata)
 axis on, hold on, xlabel ('Translation / Scaling');
 plot (outcp(:,1), outcp(:,2), 'or')
 
 % Shear
 outcp = [1 1; 160 1; 140 160; -19 160]; % affine only needs 3 control points
 T = maketform ('affine', incp(1:3,:), outcp(1:3,:));
 subplot (2,3,3); 
 [im2 xdata ydata] = imtransform (im, T, 'udata', udata,
                                  'vdata', vdata, 'fillvalues', 1);
 imh = imshow (im2); set (imh, 'xdata', xdata, 'ydata', ydata) 
 set (gca, 'xlim', xdata, 'ylim', ydata)
 axis on, hold on, xlabel ('Shear');
 plot (outcp(:,1), outcp(:,2), 'or')
 
 % Rotation 
 theta = pi/4;
 T = maketform ('affine', [cos(theta) -sin(theta); ...
                           sin(theta) cos(theta); 0 0]);
 outcp = tformfwd (T, incp);
 subplot (2,3,4); 
 [im2 xdata ydata] = imtransform (im, T, 'udata', udata,
                                  'vdata', vdata, 'fillvalues', 1 );
 imh = imshow (im2); set (imh, 'xdata', xdata, 'ydata', ydata) 
 set (gca, 'xlim', xdata, 'ylim', ydata)
 axis on, hold on, xlabel ('Rotation');
 plot (outcp(:,1), outcp(:,2), 'or')

 % Reflection around x axis
 outcp = incp;
 outcp(:,2) *= -1;
 T = cp2tform (incp, outcp, 'similarity');
 subplot (2,3,5); 
 [im2 xdata ydata] = imtransform (im, T, 'udata', udata,
                                  'vdata', vdata, 'fillvalues', 1 );
 imh = imshow (im2); set (imh, 'xdata', xdata, 'ydata', ydata) 
 set (gca, 'xlim', xdata, 'ylim', ydata)
 axis on, hold on, xlabel ('Reflection');
 plot (outcp(:,1), outcp(:,2), 'or')

 % Projection
 outcp = [1 1; 160 -40; 220 220; 12 140];
 T = maketform ('projective', incp, outcp);
 subplot (2,3,6); 
 [im2 xdata ydata] = imtransform (im, T, 'udata', udata,
                                  'vdata', vdata, 'fillvalues', 1 );
 imh = imshow (im2); set (imh, 'xdata', xdata, 'ydata', ydata) 
 set (gca, 'xlim', xdata, 'ylim', ydata)
 axis on, hold on, xlabel ('Projection');
 plot (outcp(:,1), outcp(:,2), 'or')