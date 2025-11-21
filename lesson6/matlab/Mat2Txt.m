clear;
clc;
close all;
a = imread('../img/640x480.bmp');
%a = rgb2gray(a);
imshow(a);      %显示
[row,col] = size(a);

p_fid = fopen('../data/pre.txt','w+');
for i = 1:row
     for j = 1:col 
           fprintf(p_fid,'%02x' ,a(i,j));       %%02x：以十六进制输出 2为指定的输出字段的宽度 如果位数小于2 则左端补0
           fprintf(p_fid,'\n');
     end
 end
fclose(p_fid);

%imwrite(a,'../img/post.bmp');