function FourierCt2
clc;
close;
clear;

oriData=xlsread('C:\Users\stranger\Desktop\FSC FL1\data\liquid.csv');

oriData=asinh(oriData);
if 1
oriData(oriData(:,1)<5,:)=[];
oriData(oriData(:,2)<5,:)=[];
oriData(oriData(:,1)>13,:)=[];
oriData(oriData(:,2)>13,:)=[];
end
%Max=XLim(2);

XLim=[6 13];
YLim=[6 13];
ULim=[XLim(1) XLim(2)];
VLim=[YLim(1) YLim(2)];
Lxy=(XLim(2)-XLim(1))*(YLim(2)-YLim(1));
Luv=(ULim(2)-ULim(1))*(VLim(2)-VLim(1));
pieceNum=100;
sepx=(XLim(2)-XLim(1))/pieceNum;
sepy=(YLim(2)-YLim(1))/pieceNum;
sepu=(ULim(2)-ULim(1))/pieceNum;
sepv=(VLim(2)-VLim(1))/pieceNum;


if 1
matSize=[round((XLim(2)-XLim(1))/sepx),round((YLim(2)-YLim(1))/sepx)];
dataMat=zeros([matSize(1),matSize(2)]);
[K,~]=size(oriData);
for k=1:K 
    tempData=oriData(k,:);
    tempPos=round((tempData-[XLim(1)-sepx/2,YLim(1)-sepy/2])./[sepx sepy]);
    dataMat(tempPos(1),tempPos(2))=dataMat(tempPos(1),tempPos(2))+1;
end
fv=dataMat;
end



%x·¶Î§M;y·¶Î§N
M=pieceNum;
N=pieceNum;
XList=XLim(1)+sepx/2:sepx:XLim(2)-sepx/2;
YList=YLim(1)+sepy/2:sepy:YLim(2)-sepy/2;
UList=ULim(1)+sepu/2:sepu:ULim(2)-sepu/2;
VList=VLim(1)+sepv/2:sepv:VLim(2)-sepv/2;

Xmesh=ones(pieceNum,1).*XList;
Ymesh=ones(pieceNum,1).*YList;
Umesh=ones(pieceNum,1).*UList;
Vmesh=ones(pieceNum,1).*VList;
if 1
%size(Xmesh)
%fv=piecewiseFcn(Xmesh',Ymesh,XLim(1),YLim(1),sep,dataMat);
end
fv=fv./size(oriData,1)./((sepx)*(sepy));
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
sepx2=(XLim(2)-XLim(1))/pieceNum;
sepy2=(YLim(2)-YLim(1))/pieceNum;
XList2=XLim(1)+sepx2/2:sepx2:XLim(2)-sepx2/2;
YList2=YLim(1)+sepy2/2:sepy2:YLim(2)-sepy2/2;
 ffv=zeros(pieceNum,pieceNum);
    for k=1:pieceNum
        for j=1:pieceNum
            ffv(k,j)=norm(f(XList2(k),YList2(j)));
        end
    end
    mesh(Xmesh',Ymesh,ffv)
end
end
xlabel('asinh(FSC-H)');
ylabel('asinh(SSC-H)');
zlabel('probability density');
end

