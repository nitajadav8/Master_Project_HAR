clear;
%feat = dir(fullfile('C:\MATLAB\ARC\Train_features\Train_Feat','*.mat'));
size=3;
B=[];
Label=[];


for i=1:size
    result(i)=load(['C:\MATLAB\ARC\Train_features\Train_Feat',num2str(i),'.mat']); 
    a=result(i).Train_Feat;
    
    lab(i)=load(['C:\MATLAB\ARC\Train_features\label',num2str(i),'.mat']);
    b=lab(i).label;
    Label=[Label,b];
    B=[B;a];
end
filename = fullfile('C:\MATLAB\ARC\Train_features\Final_Feat.mat');   
 save(filename,'B');
 filename = fullfile('C:\MATLAB\ARC\Train_features\Final_Label.mat');   
 save(filename,'Label');