function [pos,val,cimg,L]=STIP(f,kparam,sxl2,sxi2,pointtype,npoints)


[ysize, xsize]=size(f);
0
.....% compute scale-normalised second order matrix
L=mydiscgaussfft(extend2(f,4,4),sxl2); 

Lx=crop2(filter2(dxmask,L,'same'),4,4)*sxl2^(1/2);
Ly=crop2(filter2(dymask,L,'same'),4,4)*sxl2^(1/2);
Lxm2=Lx.*Lx;
Lym2=Ly.*Ly;
Lxmy=Lx.*Ly;

Lxm2smooth=mydiscgaussfft(Lxm2,sxi2);
Lym2smooth=mydiscgaussfft(Lym2,sxi2);
Lxmysmooth=mydiscgaussfft(Lxmy,sxi2);

if pointtype==1 % harris points  
  detC=(Lxm2smooth.*Lym2smooth)-(Lxmysmooth.^2);
  trace2C=(Lxm2smooth+Lym2smooth).^2;
  
  %kparam=0.04;
  cimg=detC-kparam*trace2C;
end


% detect maxima
[position, value, anms] = maxsupression(cimg);

pos=[];
val=[];
if size(position)>0
  pxall=position(:,2);
  pyall=position(:,1);

  % choose 'npoints' strongest responses
  [sv,si]=sort(-value);
  if nargin<6
    npoints=length(si)
  end
  px=pxall(si(1:min(npoints,length(si))));
  py=pyall(si(1:min(npoints,length(si))));
  val=-sv(1:min(npoints,length(si)));

  % threshold results
  %threshind=find(pv<=-thresh);
  %px=px(threshind);
  %py=py(threshind);

  ind=sub2ind([ysize xsize],py,px);
  c11=Lxm2smooth(ind);
  c12=Lxmysmooth(ind);
  c22=Lym2smooth(ind);

  pos=[px py sxl2*ones(size(px)) c11 c12 c12 c22];

  if 1 % discard points at image boundaries
    bound=2; % 2 pixel boundary
    insideind=find((px>bound).*(px<(xsize-bound)).*(py>bound).*(py<(ysize-bound)));
    pos=pos(insideind,:);
  end
end










