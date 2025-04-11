function gray=il_rgb2gray(rgb)
%rgb=imread(rgb);
%imshow(rgb);
%rgb = double(rgb);
%imshow(rgb);
%
% gray=il_rgb2gray(rgb)
%
%   converts n-channel image into a one channel
%   (gray) image as gray=(r+g+b+...)/n
%

if ndims(rgb)<3
  gray=rgb;
  %imshow(gray);
else
  p=sum(rgb,3);
  q=size(rgb,3);
  gray=p/q;
  %imshow(gray);
end

