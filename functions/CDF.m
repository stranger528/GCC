function [f,ffv]=CDF(oriData,pieceNum)
%oriData=xlsread('C:\Users\stranger\Desktop\FSC FL1\原始数据\plate.csv');
%oriData=oriData(:,1:2);
%oriData=log10(oriData);
%oriData=log10(oriData);
%oriData=oriData(:,7:8);
%oriData=FourierTrans_edulcoration_asinh(oriData);
clc;
close;
%Max=XLim(2);
Max=13;
Max2=5.5;
XLim=[2 Max];
YLim=[2 Max];
ULim=[XLim(1) XLim(2)];
VLim=[YLim(1) YLim(2)];
Lxy=(XLim(2)-XLim(1))*(YLim(2)-YLim(1));
Luv=(ULim(2)-ULim(1))*(VLim(2)-VLim(1));
%pieceNum=100;
sepxy=(Max-XLim(1))/pieceNum;
sepuv=2*Max2/pieceNum;

if 1
matSize=[round((XLim(2)-XLim(1))/sepxy),round((YLim(2)-YLim(1))/sepxy)];
dataMat=zeros([matSize(1),matSize(2)]);
[K,~]=size(oriData);
for k=1:K 
    tempData=oriData(k,:);
    tempPos=round((tempData-[XLim(1)-sepxy/2,YLim(1)-sepxy/2])./sepxy);
    dataMat(tempPos(1),tempPos(2))=dataMat(tempPos(1),tempPos(2))+1;
end
fv=dataMat;
end



%x范围M;y范围N
M=pieceNum;
N=pieceNum;
XList=XLim(1)+sepxy/2:sepxy:XLim(2)-sepxy/2;
YList=YLim(1)+sepxy/2:sepxy:YLim(2)-sepxy/2;
UList=ULim(1)+sepuv/2:sepuv:ULim(2)-sepuv/2;
VList=VLim(1)+sepuv/2:sepuv:VLim(2)-sepuv/2;

Xmesh=ones(pieceNum,1).*XList;
Ymesh=ones(pieceNum,1).*YList;
Umesh=ones(pieceNum,1).*UList;
Vmesh=ones(pieceNum,1).*VList;
if 1
%size(Xmesh)
%fv=piecewiseFcn(Xmesh',Ymesh,XLim(1),YLim(1),sep,dataMat);
end
fv=fv./size(oriData,1)./((sepxy)*(sepxy));
%F=@(u,v)sum(sum(exp(1i*2*pi.*Xmesh'.*u).*fv.*exp(1i*2*pi*Ymesh.*v)))*Lxy/M/N;
F=@(u,v)sum(sum(exp(1i*2*pi.*Xmesh'.*u).*fv.*exp(1i*2*pi*Ymesh.*v)))*Lxy/M/N;
for k=1:pieceNum
    for j=1:pieceNum
                         Fv(k,j)=F(UList(k),VList(j));
    end
end

if 1
    
    %f=@(x,y)sum(sum(exp(-1i*2*pi.*Umesh'.*x).*Fv.*exp(-1i.*2*pi.*Vmesh.*y)))*Luv/(M)/(N);
    f=@(x,y)sum(sum(exp(-1i*2*pi.*Umesh'.*x).*Fv.*exp(-1i.*2*pi.*Vmesh.*y)))*Luv/(M)/(N);
if 1
sepxy2=(13-XLim(1))/300;
XList2=XLim(1)+sepxy2/2:sepxy2:XLim(2)-sepxy2/2;
YList2=YLim(1)+sepxy2/2:sepxy2:YLim(2)-sepxy2/2;
 ffv=zeros(300,300);
    for k=1:300
        for j=1:300
            ffv(k,j)=norm(f(XList2(k),YList2(j)));
        end
    end
    %mesh(Xmesh',Ymesh,ffv)
end
end


end