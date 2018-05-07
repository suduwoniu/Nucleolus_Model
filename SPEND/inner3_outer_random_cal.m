n1=50;n2=50;n3=50;nprocess=1837;nrna=175;rrna=6.5;inteval=8;iter=40;ratio=12;
number_shape=24;
pnum1=7;pnum2=25;

record_file=fopen('shape_new_right/random_1.txt','wt');
for repeat=1:5
record=zeros(nprocess,6);
count1=0;
for xx=2:n1-1
    for yy=2:n2-1
        for zz=2:n3-1
            if (xx-(n1+1)/2)^2+(yy-(n2+1)/2)^2+(zz-(n3+1)/2)^2>=pnum1^2
                if (xx-(n1+1)/2)^2+(yy-(n2+1)/2)^2+(zz-(n3+1)/2)^2<=pnum2^2
                    count1=count1+1;
                    record(count1,1:3)=[xx,yy,zz];
                end
            end
        end
    end
end            

p=randperm(count1);
p1=p(1:nprocess);
randomFactor=zeros(nprocess,7);
randomFactor(:,2:4)=record(p1,1:3);

r=rrna;
theta=linspace(0,pi);
phi=linspace(0,2*pi);
[tt,pp]=meshgrid(theta,phi);
[x1,y1,z1]=sph2cart(pp,pi/2-tt,r);
s1=surf(x1,y1,z1);

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
sum(randomFactor_res(:,7))/nprocess*10*8
plot3(randomFactor_res(:,2),randomFactor(:,3),randomFactor(:,4),'.','color','red');
hold on;
plot3(inner(:,1),inner(:,2),inner(:,3),'.','color','black');
hold off;
axis([0,50,0,50,0,50]);
file=['inner3_shape_new_right/effect_all_innerBall_outer_random_.txt',num2str(repeat),'.txt'];
type_w=fopen(file,'wt');
for n=1:nprocess
    fprintf(type_w,'%d\t%d\t%d\t%d\t%d\t%d\n',randomFactor(n,2),randomFactor(n,3),randomFactor(n,4),randomFactor(n,5),randomFactor(n,6),randomFactor_res(n,7)*(80));
end
fprintf(record_file,'%d\n',sum(randomFactor_res(:,7))/nprocess*10*8);
end
fclose('all');

%{
a=load('inner3_shape_new_right/random_1.txt');
max(a)
%}