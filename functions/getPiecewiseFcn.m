function [piecewiseFcn,dataMat]=getPiecewiseFcn(data,XLim,YLim,pieceNum)
%data=load('FCMdata1_edulcorData_asinh.mat');
%data=data.edulcorData;
%XLim=[0 10];YLim=[0 10];
%pieceNum=[50,50];
sep=[(XLim(2)-XLim(1))/pieceNum(1),(YLim(2)-YLim(1))/pieceNum(2)];
dataMat=zeros(pieceNum);
for i=1:size(data,1)
    tempData=data(i,:);
    tempPos=round([(tempData(1)-XLim(1)+sep(1)/2)/sep(1),(tempData(2)-YLim(1)+sep(2)/2)/sep(2)]);
    dataMat(tempPos(1),tempPos(2))=dataMat(tempPos(1),tempPos(2))+1;
end
piecewiseFcn=@(x,y,Xmin,Ymin,sep,dataMat)dataMat(round((x-Xmin+sep(1)/2)./sep(1))+(round((y-Ymin+sep(2)/2)./sep(2))-1)*size(dataMat,1))./(sum(sum(dataMat)*sep(1)*sep(2)));
%piecewiseFcn=@(x,y)dataMat(round((x-Xmin+sep(1)/2)./sep(1))+(round((y-Ymin+sep(2)/2)./sep(2))-1)*size(dataMat,1))./(sum(sum(dataMat)*sep(1)*sep(2)));
end