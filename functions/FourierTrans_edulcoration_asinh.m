function edulcorData=FourierTrans_edulcoration_asinh(oriData)
clc

%oriData=asinh(oriData);
oriData(oriData(:,1)<1,:)=[];
oriData(oriData(:,2)<1,:)=[];
oriData(oriData(:,1)>100000,:)=[];
oriData(oriData(:,2)>100000,:)=[];
%Max=12;
Max=100000;
XLim=[0 Max];YLim=[0 Max];
pieceNum=3500;
sep=Max/pieceNum;

matSize=[round((XLim(2)-XLim(1))/sep),round((YLim(2)-YLim(1))/sep)];
dataMat=zeros([matSize(1),matSize(2)]);

for i=1:size(oriData,1)  
    tempData=oriData(i,:);
    tempPos=round((tempData-[XLim(1)-sep/2,YLim(1)-sep/2])./sep);
    dataMat(tempPos(1),tempPos(2))=dataMat(tempPos(1),tempPos(2))+1;
end
subplot(2,2,1)
showPic=dataMat';showPic=showPic(end:-1:1,:);
imshow(showPic)

FFT=fft2(dataMat);
myangle=angle(FFT);             
FS=abs(fftshift(FFT));

cutoff=150;
[m,n]=size(FS);
FS(1:round(m/2)-cutoff,:)=0;
FS(round(m/2)+cutoff:m,:)=0;
FS(round(m/2)-cutoff:round(m/2)+cutoff,1:round(n/2)-cutoff)=0;
FS(round(m/2)-cutoff:round(m/2)+cutoff,round(n/2)+cutoff:n)=0;

coe=ifftshift(FS);          
ISF=coe.*cos(myangle)+coe.*sin(myangle).*1i;
FR=abs(ifft2(ISF));

subplot(2,2,2)
showPic=FR';showPic=showPic(end:-1:1,:);
imshow(showPic)

edulcorData=oriData;
matPosList=round((edulcorData-[XLim(1)-sep/2,YLim(1)-sep/2])./sep);
oneOrderList=matPosList(:,1)+(matPosList(:,2)-1).*size(FR,1);
deleteList=round(FR(oneOrderList))==0;
edulcorData(deleteList,:)=[];
subplot(2,2,3)

scatter(edulcorData(:,1),edulcorData(:,2),0.5,'filled')
edulcorData=asinh(edulcorData);
%save FCMdata1_edulcorData_asinh.mat edulcorData



end