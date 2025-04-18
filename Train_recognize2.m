close all
clear all
clc
delete('Frames\*.jpg');
%[filename pathname] = uigetfile({'*.avi'},'Select A Video File'); 
I = VideoReader('KTH Dataset\bx1.avi');
%implay('KTH Dataset\bx1.avi');
%pause(0.3);
nFrames = I.numberofFrames;
vidHeight =  I.Height;
vidWidth =  I.Width;
mov(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);
       WantedFrames = 50;
for k = 1:WantedFrames
    mov(k).cdata = read( I, k);
   mov(k).cdata = imresize(mov(k).cdata,[256,256]);
    imwrite(mov(k).cdata,['Frames\',num2str(k),'.jpg']);
end

%for I = 1:WantedFrames
 %  im=imread(['Frames\',num2str(I),'.jpg']);
  %  figure(1),subplot(5,10,I),imshow(im);
%end
clc
for i=1:WantedFrames
    disp(['Processing frame no.',num2str(i)]);
  img=imread(['Frames\',num2str(i),'.jpg']);
  f1=il_rgb2gray(double(img));
  [ysize,xsize]=size(f1);
  nptsmax=40;   
  kparam=0.04;  
  pointtype=1;  
  sxl2=4;       
  sxi2=2*sxl2;  
  % detect points
  [posinit,valinit]=STIP(f1,kparam,sxl2,sxi2,pointtype,nptsmax);
  Train_Feat(i,1:40)=valinit;
  label(i)=2;
  %imshow(f1,[]), hold on
 % axis off;
 % showellipticfeatures(posinit,[1 1 0]);
 % title('Feature Points','fontsize',12,'fontname','Times New Roman','color','Black')
end
 filename = fullfile('C:\MATLAB\ARC\Train_features\Train_Feat2.mat');   %Writing the keyframes
 save(filename,'Train_Feat');
 filename = fullfile('C:\MATLAB\ARC\Train_features\label2.mat');  
 save(filename,'label');