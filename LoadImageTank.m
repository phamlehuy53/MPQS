function [v_ImageTank,v_AlphaTank,v_ImageTankDied,v_AlphaTankDied]=LoadImageTank()

[v_ImageTank, ~, v_AlphaTank]	= imread('tank.png');
v_ImageTank = imresize(v_ImageTank, [ImageWidth 50], 'lanczos3' );
v_AlphaTank = imresize(v_AlphaTank, [ImageWidth 50], 'lanczos3' );

[v_ImageTankDied, ~, v_AlphaTankDied]	= imread('tankdied.png');
v_ImageTankDied = imresize(v_ImageTankDied, [ImageWidth 50], 'lanczos3' );
v_AlphaTankDied = imresize(v_AlphaTankDied, [ImageWidth 50], 'lanczos3' );


