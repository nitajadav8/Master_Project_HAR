function [val]=STIP(f,kparam,sxl2,sxi2,pointtype,npoints)


[ysize, xsize]=size(f);

L=mydiscgaussfft(extend2(f,4,4),sxl2); 

Lx=crop2(filter2(dxmask,L,'same'),4,4)*sxl2^(1/2);
Ly=crop2(filter2(dymask,L,'same'),4,4)*sxl2^(1/2);
Lxm2=Lx.*Lx;
Lym2=Ly.*Ly;
Lxmy=Lx.*Ly;

Lxm2smooth=mydiscgaussfft(Lxm2,sxi2);
Lym2smooth=mydiscgaussfft(Lym2,sxi2);
Lxmysmooth=mydiscgaussfft(Lxmy,sxi2);

if pointtype==1  
  detC=(Lxm2smooth.*Lym2smooth)-(Lxmysmooth.^2);
  trace2C=(Lxm2smooth+Lym2smooth).^2;
  
  
  cimg=detC-kparam*trace2C;
end




[position, value, anms] = maxsupression(cimg);

pos=[];
val=[];
if size(position)>0
  pxall=position(:,2);
  pyall=position(:,1);

  
  [sv,si]=sort(-value);
  if nargin<6
    npoints=length(si);
  end
  px=pxall(si(1:min(npoints,length(si))));
  py=pyall(si(1:min(npoints,length(si))));
  val=-sv(1:min(npoints,length(si)));
end










