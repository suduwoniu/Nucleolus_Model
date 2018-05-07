n1=50;n2=50;n3=50;nprocess=1837;nrna=175;rrna=6.5;inteval=8;iter=40;ratio=12;
number_shape=90;
pnum1=14;pnum2=15;
R_select=4;
R_vert=2.3;
record_file=fopen('inner3_shape_new_right/unit_90.txt','wt');
for repeat=1:10
%field build
filed=zeros(n1,n2,n3);
filedNum=zeros(1,4);
count=0;
n11=(n1+1)/2;n21=(n2+1)/2;n31=(n3+1)/2;
for xx=1:n1
    for yy=1:n2
        for zz=1:n3
            if ((xx-n11)^2+(yy-n21)^2+(zz-n31)^2)>=(pnum1^2)
                if ((xx-n11)^2+(yy-n21)^2+(zz-n31)^2)<=(pnum2^2)
                count=count+1;
                filedNum(count,1)=count;
                filedNum(count,2)=xx;
                filedNum(count,3)=yy;
                filedNum(count,4)=zz;
                filedNum(count,5)=1;
                end
            end
        end
    end
end

Rselect=zeros(1,3);
Rcenter_1=filedNum(:,2:4);
for num=1:number_shape
    Rs=size(Rcenter_1);
    del=zeros(1);
    p=randperm(Rs(1));
    count1=0;
    Rselect(num,:)=Rcenter_1(p(1),:);
    for n=1:Rs(1)
        if sqrt((Rcenter_1(n,1)-Rselect(num,1))^2+(Rcenter_1(n,2)-Rselect(num,2))^2+(Rcenter_1(n,3)-Rselect(num,3))^2)<=R_select
            count1=count1+1;
            del(count1)=n;
        end
    end
    Rcenter_1(del,:)=[];
end

vert=Rselect;
filed=zeros(n1,n2,n3);
filedNum=zeros(1,4);
count=0;
n11=(n1+1)/2;n21=(n2+1)/2;n31=(n3+1)/2;
for xx=1:n1
    for yy=1:n2
        for zz=1:n3
            for n=1:number_shape
                if ((xx-vert(n,1))^2+(yy-vert(n,2))^2+(zz-vert(n,3))^2)<R_vert^2
                count=count+1;
                filedNum(count,1)=count;
                filedNum(count,2)=xx;
                filedNum(count,3)=yy;
                filedNum(count,4)=zz;
                filedNum(count,5)=1;
                end
            end
        end
    end
end 

p=randperm(count);
p1=p(1:nprocess);
randomFactor=filedNum(p1,1:5);

count0=0;
for xx=18:33
    for yy=18:33
        for zz=18:33
            if sqrt((xx-n11)^2+(yy-n22)^2+(zz-n33)^2)>=7 && sqrt((xx-n11)^2+(yy-n22)^2+(zz-n33)^2)<=8
                count0=count0+1;
                inner(count0,1:3)=[xx,yy,zz];
            end
        end
    end
end

count1=0;
pol=zeros(1,5);
for k=1:count0
    [theta,phi,r]=cart2sph(inner(k,1)-25.5,inner(k,2)-25.5,inner(k,3)-25.5);
    if phi>-1/4*pi && phi<=1/4*pi 
        if (theta>=-1/8*pi && theta <=1/8*pi) || (theta>=13/24*pi && theta<=19/24*pi) || (theta>=-19/24*pi && theta<=-13/24*pi)
            count1=count1+1;
            pol(count1,1:3)=inner(k,1:3);
        end
    end
end

pinner=randperm(count1);
pinner1=pinner(1:nrna);
RRNA=pol(pinner1,:);
inner=RRNA;


nrna=count3;
for n=1:nprocess
    dist0=99999999999;idx=0;
    for k=1:nrna
        if inner(k,4)<ratio
            dist1=sqrt((randomFactor(n,2)-inner(k,1))^2+(randomFactor(n,3)-inner(k,2))^2+(randomFactor(n,4)-inner(k,3))^2);
            if dist1<dist0
                dist0=dist1;
                idx=k;
            end
        end
    end
    randomFactor(n,5)=idx;
    randomFactor(n,6)=dist0;
    inner(idx,4)=inner(idx,4)+1;
end

%[randomFactor_res]=CalEffect_usual(randomFactor,inner,n1,n2,n3,rrna);
[randomFactor_res]=CalEffect_all_new_v4(randomFactor,inner,n1,n2,n3,5);
sum(randomFactor_res(:,7))/nprocess*80
plot3(randomFactor_res(:,2),randomFactor(:,3),randomFactor(:,4),'.','color','red');
hold on;
plot3(inner(:,1),inner(:,2),inner(:,3),'.','color','black');
hold off;
axis([0,50,0,50,0,50]);
file=['inner3_shape_new_right/effect_all_innerBall_outerSmallUnit_90_',num2str(repeat),'.txt'];
type_w=fopen(file,'wt');
for n=1:nprocess
    fprintf(type_w,'%d\t%d\t%d\t%d\t%d\t%d\n',randomFactor(n,2),randomFactor(n,3),randomFactor(n,4),randomFactor(n,5),randomFactor(n,6),randomFactor_res(n,7)*(80));
end
fprintf(record_file,'%d\n',sum(randomFactor_res(:,7))/nprocess*80);
end
fclose('all');
a=load('inner3_shape_new_right/unit_90.txt');
max(a)
%{
type_w=fopen('model_res/inner_point.txt','wt');
for n=1:nrna
    fprintf(type_w,'%d\t%d\t%d\n',inner(n,1),inner(n,2),inner(n,3));
end
%}