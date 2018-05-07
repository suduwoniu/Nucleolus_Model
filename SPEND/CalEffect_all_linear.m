function[randomFactor_1]=CalEffect_all_linear(randomFactor,inner,n1,n2,n3)
s=size(randomFactor);
position=zeros(n1,n2,n3);
for n=1:s(1)
    position(randomFactor(n,2),randomFactor(n,3),randomFactor(n,4))=1;
end
    
for n=1:s(1)
    fac=randomFactor(n,:);
    %inn=inner(fac(5),:);
    inn=[n1/2,n2/2,n3/2];
    inn=round(inn);
    %xd=abs(inn(1)-fac(2));yd=abs(inn(2)-fac(2));zd=abs(inn(3)-fac(3));
    xd=inn(1)-fac(2);yd=inn(2)-fac(3);zd=inn(3)-fac(4);
    [mx,idx]=max([abs(xd),abs(yd),abs(zd)]);
    if xd<0
        x1=inn(1);x2=fac(2);
    else
        x1=fac(2);x2=inn(1);
    end
    if yd<0
        y1=inn(2);y2=fac(3);
    else
        y1=fac(3);y2=inn(2);
    end
    if zd<0
        z1=inn(3);z2=fac(4);
    else
        z1=fac(4);z2=inn(3);
    end
    
    count1=0;
    if idx==1
        for k=x1:x2
            density=sum(sum(sum((position(k,y1:y2,z1:z2)))));
            count1=count1+log(density+1);
        end
    end
    if idx==2
        for k=y1:y2
            density=sum(sum(sum(position(x1:x2,k,z1:z2))));
            count1=count1+log(density+1);
        end
    end
    if idx==3
        for k=z1:z2
            density=sum(sum(sum(position(x1:x2,y1:y2,k))));
            count1=count1+log(density+1);
        end
    end
    
    l1=sqrt((fac(2)-1)^2+(fac(3)-1)^2+(fac(4)-1)^2);
    l2=sqrt((fac(2)-n1)^2+(fac(3)-1)^2+(fac(4)-1)^2);
    l3=sqrt((fac(2)-n1)^2+(fac(3)-n2)^2+(fac(4)-1)^2);
    l4=sqrt((fac(2)-1)^2+(fac(3)-n2)^2+(fac(4)-1)^2);
    l5=sqrt((fac(2)-1)^2+(fac(3)-1)^2+(fac(4)-1)^2);
    l6=sqrt((fac(2)-n1)^2+(fac(3)-1)^2+(fac(4)-n3)^2);
    l7=sqrt((fac(2)-n1)^2+(fac(3)-n2)^2+(fac(4)-n3)^2);
    l8=sqrt((fac(2)-1)^2+(fac(3)-n2)^2+(fac(4)-n3)^2);
    [mn1,idx1]=min([l1,l2,l3,l4,l5,l6,l7,l8]);
    count2=0;
    if idx1==1
        count2=calDensity([1,1,1],fac(2:4),position);
    end
    if idx1==2
        count2=calDensity([n1,1,1],fac(2:4),position);
    end
    if idx1==3
        count2=calDensity([n1,n2,1],fac(2:4),position);
    end
    if idx1==4
        count2=calDensity([1,n2,1],fac(2:4),position);
    end
    if idx1==5
        count2=calDensity([1,1,n3],fac(2:4),position);
    end
    if idx1==6 
        count2=calDensity([n1,1,n3],fac(2:4),position);
    end
    if idx1==7
        count2=calDensity([n1,n2,n3],fac(2:4),position);
    end
    if idx1==8
        count2=calDensity([1,n2,n3],fac(2:4),position);
    end
    
    point2=fac(2:4);
    count3=0;
    for ii=-1:1
         for jj=-1:1
             for kk=-1:1
                 if point2(1)+ii>0 && point2(1)+ii<=n1 && point2(2)+jj>0 && point2(2)+jj<=n2 && point2(3)+kk>0 && point2(3)+kk<=n3
                     if position(point2(1)+ii,point2(2)+jj,point2(3)+kk)==1
                         count3=count3+1;
                     end
                 end
             end
         end
    end
    count3=1;
    eff=count3/(count1+count2);
    randomFactor(n,7)=eff;
    randomFactor(n,8)=count3;
    randomFactor(n,9)=count1;
    randomFactor(n,10)=count2;
end

randomFactor_1=randomFactor;
end
