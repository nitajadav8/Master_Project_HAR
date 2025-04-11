
clc;
clear all;
%V = 'hc.avi';      %Video Name 
xyloObj = VideoReader('hc2.avi');   %Using video reader reading video
count = 0;
   %Extracting frames
   T= xyloObj.NumberOfFrames            % Calculating number of frames
   for g=1:T
           p=read( xyloObj,g);          % Retrieve data from video
           if(g~=  xyloObj.NumberOfFrames)
                 J=read( xyloObj,g+1);
                 th=difference(p,J);        %To calculate histogram difference between two frames 
                 X(g)=th;
           end
   end
   %calculating mean and standard deviation and extracting frames
   mean=mean2(X)
   std=std2(X)
   threshold=std+mean*4
  delete('key_frames\*.jpg');
   for g=1: T
       p =  read(xyloObj,g);
       if(g~=xyloObj.NumberOfFrames)
        J= read(xyloObj,g+1);
        th=difference(p,J);
        if(th>mean)    % Greater than threshold select as a key frame
            image_stack=J;
            count = count+1;
            filename = fullfile('C:\MATLAB\A1_imple\key_frames\', sprintf('%d.jpg',count));   %Writing the keyframes
            imwrite(image_stack, filename);
            save test image_stack;
             
        end 
   end
      
   end 
   for i=1:count
       
   disp(['Processing frame no.',num2str(i)]);
             img=imread(['key_frames\',num2str(i),'.jpg']);
            f1=il_rgb2gray(double(img));
          [ysize,xsize]=size(f1);       
          nptsmax=40;   
        kparam=0.04;  
        pointtype=1;  
        sxl2=4;       
        sxi2=2*sxl2;  
  % detect points
              [posinit,valinit,cimg]=STIP(f1,kparam,sxl2,sxi2,pointtype,nptsmax);
            Test_Feat(i,1:40)=valinit;
           % pos_val(i,1:40)=posinit;
          
  imshow(f1,[]),
  hold on
  axis off;
  impixelinfo
  showellipticfeatures(posinit,[1 1 0]);
  title('Feature Points','fontsize',12,'fontname','Times New Roman','color','Black')
   
   end
  save stip_test Test_Feat;
  [centers1,labels1,mimdist1]=kmeans(Test_Feat,50);
  ind1=find(labels1<=2);
  showcirclefeatures_xyt(image_stack,posinit(ind1,:),labels1(ind1));
