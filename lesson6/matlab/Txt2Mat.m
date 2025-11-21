clear;
clc;
close all;

a = textread('../data/post.txt','%s');
IMdec = hex2dec(a);     %文本转为字符数组

col = 640;
row = 480;

IM = reshape(IMdec,col,row);        %IMdec数组转为col长 row宽的矩阵
b = uint8(IM)';     %'转置操作符：对转换后的 uint8(IM) 矩阵进行转置操作 转置操作会将矩阵的行和列互换

imwrite(b,'../img/post.bmp');
imshow('../img/post.bmp');



