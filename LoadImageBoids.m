function [v_ImageR,v_AlphaR,v_ImageB,v_AlphaB,v_ImageE,v_AlphaE]=LoadImageBoids()
global ImageWidth;
ImageWidth=70;
[v_ImageR, ~, v_AlphaR]	= imread('soldier_01.png');
v_ImageR = imresize(v_ImageR, [ImageWidth 50], 'lanczos3' );
v_AlphaR = imresize(v_AlphaR, [ImageWidth 50], 'lanczos3' );


[v_ImageB, ~, v_AlphaB]	= imread('soldier_02.png');
v_ImageB = imresize(v_ImageB, [ImageWidth 50], 'lanczos3' );
v_AlphaB = imresize(v_AlphaB, [ImageWidth 50], 'lanczos3' );

[v_ImageE, ~, v_AlphaE]	= imread('rip.png');
v_ImageE = imresize(v_ImageE, [ImageWidth ImageWidth], 'lanczos3' );
v_AlphaE = imresize(v_AlphaE, [ImageWidth ImageWidth], 'lanczos3' );

