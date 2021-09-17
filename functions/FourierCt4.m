function FourierCt4
clc;
close;
clear;
%oriData1=xlsread('C:\Users\stranger\Desktop\FSC FL1\原始数据\plate.csv');
oriData1=xlsread('C:\Users\stranger\Desktop\FSC FL1\data\Beads_100.csv');
oriData2=xlsread('C:\Users\stranger\Desktop\FSC FL1\data\data_200.csv');
oriData3=xlsread('C:\Users\stranger\Desktop\FSC FL1\data\data_500.csv');
oriData4=xlsread('C:\Users\stranger\Desktop\FSC FL1\data\data_1000.csv');
oriData5=xlsread('C:\Users\stranger\Desktop\FSC FL1\data\data_2000.csv');
oriData1=[oriData1;oriData1;oriData1;oriData1];
oriData=[oriData1(:,13:14);oriData2(:,13:14);oriData3(:,13:14);oriData4(:,13:14);oriData5(:,13:14)];
%oriData=[oriData1(:,13:14);oriData3(:,13:14);oriData4(:,13:14);oriData5(:,13:14)];
%oriData=oriData(:,13:14);


%oriData=xlsread('C:\Users\stranger\Desktop\FSC FL1\原始数据\plate.csv');
%oriData=oriData(:,1:2);
%oriData=log10(oriData);
%oriData=log10(oriData);
%oriData=oriData(:,7:8);
oriData=log10(oriData);
if 1
oriData(oriData(:,1)<1,:)=[];
oriData(oriData(:,2)<1,:)=[];
oriData(oriData(:,1)>8,:)=[];
oriData(oriData(:,2)>8,:)=[];
end
Max=8;
Max2=4;
XLim=[0 Max];
YLim=[0 Max];
ULim=[-Max2 Max2];
VLim=[-Max2 Max2];
Lxy=(XLim(2)-XLim(1))*(YLim(2)-YLim(1));
Luv=(ULim(2)-ULim(1))*(VLim(2)-VLim(1));
pieceNum=400;
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
end
