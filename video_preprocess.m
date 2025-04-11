clc;
clear all;
%V = 'hc.avi';      %Video Name 
xyloObj = VideoReader('dataset\person01\1hc1.avi');   %Using video reader reading video
count = 0;
   %Extracting frames
   T= xyloObj.NumberOfFrames            % Calculating number of frames
   for g=1:T
           p=read( xyloObj,g);          % Retrieve data from video
           if(g~=  xyloObj.NumberOfFrames)
                 J=read( xyloObj,g+1);
                 th=difference(p,J);        %To calculate histogram difference between two frames 
                 dif(g)=th;
           end
   end
   %calculating mean and standard deviation and extracting frames
   mean=mean2(dif);
   std=std2(dif);
 %  threshold=std+mean*4
  delete('key_frames\*.jpg');
   for g=1: T
       p =  read(xyloObj,g);
       if(g~=T)
        J= read(xyloObj,g+1);
        diff=difference(p,J);
        if(diff>mean)    % Greater than threshold select as a key frame
            image_stack=J;
            count = count+1;
            filename = fullfile('C:\MATLAB\ARC2\key_frames\', sprintf('%d.jpg',count));   %Writing the keyframes
            imwrite(image_stack, filename);
          %  save test image_stack;
             
        end 
   end
      
   end 
imageNames = dir(fullfile('C:\MATLAB\ARC2\key_frames\','*.jpg'));
imageNames = {imageNames.name}';
outputVideo = VideoWriter(fullfile('C:\MATLAB\ARC2\key_frames\','key_video.avi'));
outputVideo.FrameRate = xyloObj.FrameRate;
open(outputVideo);
for ii = 1:length(imageNames)
   img = imread(fullfile('C:\MATLAB\ARC2\key_frames\',imageNames{ii}));
   writeVideo(outputVideo,img)
end
close(outputVideo)
shuttleAvi = VideoReader(fullfile('C:\MATLAB\ARC2\key_frames\','key_video.avi'));
 ii = 1;
while hasFrame(shuttleAvi)
   mov(ii) = im2frame(readFrame(shuttleAvi));
   ii = ii+1;
end
movie(mov,1,shuttleAvi.FrameRate);
