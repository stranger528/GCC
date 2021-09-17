function [pieceNum,piecewiseFcn,dataMat,sep,XLim,YLim,error1]=getPwFcn(data)
%data=load('FCMdata1_edulcorData_asinh.mat');
%data=data.edulcorData;
XLim=[2 13];YLim=[2 13];
stepMin=[0 0];
stepMin(1,:)=[];
for i=1:1:1000
    offset=[inf 0];
    for j=10:i:10000
        pieceNum_L=[j,j];
        [piecewiseFcn_L,dataMat_L]=getPiecewiseFcn(data,XLim,YLim,pieceNum_L);
        sep_L=[(XLim(2)-XLim(1))/pieceNum_L(1),(YLim(2)-YLim(1))/pieceNum_L(2)];
        
        pieceNum_N=[j+1,j+1];
        [piecewiseFcn_N,dataMat_N]=getPiecewiseFcn(data,XLim,YLim,pieceNum_N);
        sep_N=[(XLim(2)-XLim(1))/pieceNum_N(1),(YLim(2)-YLim(1))/pieceNum_N(2)];
        
        
        [XSet,YSet]=meshgrid(XLim(1):1e-2:XLim(2)-1e-6,YLim(1):1e-2:YLim(2)-1e-6);
        ValueSet_L=piecewiseFcn_L(XSet,YSet,XLim(1),YLim(1),sep_L,dataMat_L);
        ValueSet_N=piecewiseFcn_N(XSet,YSet,XLim(1),YLim(1),sep_N,dataMat_N);
        %offset(round(i/1000-24))=sum(sum(abs(ValueSet_L-ValueSet_N)));
        disp([i,j])
        ValueSet_L=ValueSet_L(:);
        ValueSet_N=ValueSet_N(:);
        tempPntSet=abs(ValueSet_L-ValueSet_N);
        maxPos=find(tempPntSet==max(tempPntSet));maxPos=maxPos(1);
        %offset(2)=max(tempPntSet)/min(ValueSet_L(maxPos),ValueSet_N(maxPos));
        offset(2)=max(tempPntSet);
        %offset(2)=sqrt(sum(sum((ValueSet_L-ValueSet_N).^2))*(XLim(2)-XLim(1))*(YLim(2)-YLim(1))/(size(XSet,1)*size(XSet,2)));
        if offset(2)>offset(1)
            break;
        end
        offset(1)=offset(2);
    end
    stepMin=[stepMin;j,offset(1)];
end
disp(stepMin);

tempPos=find(stepMin(:,2)==min(stepMin(:,2)));
tempPos=tempPos(end);
pieceNum=[stepMin(tempPos) stepMin(tempPos)];
sep=[(XLim(2)-XLim(1))/pieceNum(1),(YLim(2)-YLim(1))/pieceNum(2)];
[piecewiseFcn,dataMat]=getPiecewiseFcn(data,XLim,YLim,pieceNum);
error1=min(stepMin(:,2));

disp(error1)
disp(pieceNum)


%save pieceWiseFcn.mat pieceNum piecewiseFcn dataMat sep XLim YLim error1

%sum(sum(dataMat_L(dataMat_L>1)))
end