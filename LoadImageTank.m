function [v_ImageTank,v_AlphaTank,v_ImageTankDied,v_AlphaTankDied]=LoadImageTank()

[v_ImageTank, ~, v_AlphaTank]	= imread('tank.png');

v_ImageTank = imresize(v_ImageTank, [90 90], 'lanczos3' );
v_AlphaTank = imresize(v_AlphaTank, [90 90], 'lanczos3' );

[v_ImageTankDied, ~, v_AlphaTankDied]	= imread('rip.png');
v_ImageTankDied = imresize(v_ImageTankDied, [40 40], 'lanczos3' );
v_AlphaTankDied = imresize(v_AlphaTankDied, [40 40], 'lanczos3' );


