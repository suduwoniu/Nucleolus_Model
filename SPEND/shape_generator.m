addpath('/Users/wangying/new_work/YaoRunWen/model_m/Molecular_Kinetics/')
n1=50;n2=50;n3=50;nprocess=1837;nrna=175;rrna=6.5;inteval=7;iter=40;pnum1=6.5;pnum2=25;ratio=4;vert_num=2;
%field build
filed=zeros(n1,n2,n3);
filedNum=zeros(prod(size(filed)),4);
count=1;
n11=(n1+1)/2;n21=(n2+1)/2;n31=(n3+1)/2;
for xx=1:n1
    for yy=1:n2
        for zz=1:n3
            if ((xx-n11)^2+(yy-n21)^2+(zz-n31)^2)>=(pnum1^2)
                if ((xx-n11)^2+(yy-n21)^2+(zz-n31)^2)<=(pnum2^2)
                filedNum(count,1)=count;
                filedNum(count,2)=xx;
                filedNum(count,3)=yy;
                filedNum(count,4)=zz;
                filedNum(count,5)=1;
                count=count+1;
                end
            end
        end
    end
end

%changfangxing
point=zeros(nprocess,3);
count=0;
while(count<800)
    x=round(rand*50);
    y=round(normrnd(25,5));
    z=round(normrnd(25,8));
    if (x>0 && y>0 && z>0 && x<=n1 && y<=n2 && z<=n3)
        if sqrt((x-n1/2)^2+(y-n2/2)^2+(z-n3/2)^2)>rrna
            cn=0;
            for k=1:nprocess
                if (sum(point(k,:)==[x,y,z])==3)
                    cn=cn+1;
                end
            end
            if cn==0
                count=count+1;
                point(count,:)=[x,y,z];
            end
        end
    end
end

%possion
point=zeros(nprocess,3);
count=0;
while(count<800)
    x=rand*50;
    y=poissrnd(25);
    z=poissrnd(25);
    if (x>0 && y>0 && z>0 && x<=n1 && y<=n2 && z<=n3)
        if sqrt((x-n1/2)^2+(y-n2/2)^2+(z-n3/2)^2)>rrna
            cn=0;
            for k=1:nprocess
                if (sum(point(k,:)==[x,y,z])==3)
                    cn=cn+1;
                end
            end
            if cn==0
                count=count+1;
                point(count,:)=[x,y,z];
            end
        end
    end
end      
        
plot3(point(:,1),point(:,2),point(:,3),'.')  

%changfangxing
point=zeros(nprocess,3);
point(:,1)=round(linspace(1,50,800));

count=0;
while(count<800)
    y=round(normrnd(25,5));
    z=round(normrnd(25,5));
    if (x>0 && y>0 && z>0 && x<=n1 && y<=n2 && z<=n3)
        if sqrt((x-n1/2)^2+(y-n2/2)^2+(z-n3/2)^2)>rrna
            cn=0;
            for k=1:nprocess
                if (sum(point(k,:)==[x,y,z])==3)
                    cn=cn+1;
                end
            end
            if cn==0
                count=count+1;
                point(count,2:3)=[y,z];
            end
        end
    end
end

x=1:50;
y=1:50;
z=1:50;
for xx=1:50
    for yy=1:50
        for zz=1:50
            plot3(x,y,z);
            hold on;
        end
    end
end
hold off;

x=1:50;
y=1:50;
[X,Y]=meshgrat(x,y);
Z=sin(X+Y);
surf(X,Y,Z);

%shape1:changfangxing
point=zeros(nprocess,3);
count=0;
while(count<nprocess)
    x=round(rand*50);
    y=round(normrnd(25,5));
    z=round(normrnd(25,8));
    if (x>0 && y>0 && z>0 && x<=n1 && y<=n2 && z<=n3)
        if sqrt((x-n1/2)^2+(y-n2/2)^2+(z-n3/2)^2)>rrna
            cn=0;
            for k=1:nprocess
                if (sum(point(k,:)==[x,y,z])==3)
                    cn=cn+1;
                end
            end
            if cn==0
                count=count+1;
                point(count,:)=[x,y,z];
            end
        end
    end
end
record=point;
save('point/point_1','record');

%shape2 4面体
point_1=[25,25,45];
point_2=[25,10,10];
point_3=[12,32.5,10];
point_4=[38,32.5,10];
syms A B D;
S=solve(A*point_1(1)+B*point_1(2)+point_1(3)+D==0,A*point_2(1)+B*point_2(2)+point_2(3)+D==0,point_3(1)*A+point_3(2)*B+point_3(3)+D==0);
vert=zeros(1,3);
vert(1,:)=[double(S.A),double(S.B),double(S.D)];
syms A B D;
S=solve(A*point_1(1)+B*point_1(2)+point_1(3)+D==0,A*point_2(1)+B*point_2(2)+point_2(3)+D==0,point_4(1)*A+point_4(2)*B+point_4(3)+D==0);
vert(2,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(A*point_2(1)+B*point_2(2)+point_2(3)+D==0,point_3(1)*A+point_3(2)*B+point_3(3)+D==0,point_4(1)*A+point_4(2)*B+point_4(3)+D==0);
vert(3,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(A*point_1(1)+B*point_1(2)+point_1(3)+D==0,point_3(1)*A+point_3(2)*B+point_3(3)+D==0,point_4(1)*A+point_4(2)*B+point_4(3)+D==0);
vert(4,:)=[double(S.A),double(S.B),double(S.D)];

count=0;
record=zeros(1,3);
for x=1:50;
    for y=1:50
        for z=1:50
            if (x-25)^2+(y-25)^2+(z-25)^2>6.5^2
                if x*vert(1,1)+y*vert(1,2)+z+vert(1,3)<=0
                    if x*vert(2,1)+y*vert(2,2)+z+vert(2,3)<=0
                        if x*vert(3,1)+y*vert(3,2)+z+vert(3,3)>=0
                            if x*vert(4,1)+y*vert(4,2)+z+vert(4,3)<=0
                                count=count+1;
                                record(count,:)=[x,y,z];
                            end
                        end
                    end
                end
            end
        end
    end
end
p=randperm(count);
p1=p(1:nprocess);
point=zeros(nprocess,3);
point=record(p1,:);
save('point/point_2','record');

%shape3 5面体
v1=[25,25,45];
v2=[25,45,10];
v3=[10,25,10];
v4=[25,10,10];
v5=[45,25,10];
vert=zeros(5,3);
syms A B D;
S=solve(v1(1)*A+v1(2)*B+v1(3)+D==0,v2(1)*A+v2(2)*B+v2(3)+D==0,v3(1)*A+v3(2)*B+v3(3)+D==0);
vert(1,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(v1(1)*A+v1(2)*B+v1(3)+D==0,v4(1)*A+v4(2)*B+v4(3)+D==0,v3(1)*A+v3(2)*B+v3(3)+D==0);
vert(2,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(v1(1)*A+v1(2)*B+v1(3)+D==0,v4(1)*A+v4(2)*B+v4(3)+D==0,v5(1)*A+v5(2)*B+v5(3)+D==0);
vert(3,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(v1(1)*A+v1(2)*B+v1(3)+D==0,v2(1)*A+v2(2)*B+v2(3)+D==0,v5(1)*A+v5(2)*B+v5(3)+D==0);
vert(4,:)=[double(S.A),double(S.B),double(S.D)];
vert(5,:)=[0,0,-15];

count=0;
record=zeros(1,3);
for x=1:50;
    for y=1:50
        for z=1:50
            if (x-25)^2+(y-25)^2+(z-25)^2>6.5^2
                if x*vert(1,1)+y*vert(1,2)+z+vert(1,3)<=0
                    if x*vert(2,1)+y*vert(2,2)+z+vert(2,3)<=0
                        if x*vert(3,1)+y*vert(3,2)+z+vert(3,3)<=0
                            if x*vert(4,1)+y*vert(4,2)+z+vert(4,3)<=0
                                if x*vert(5,1)+y*vert(5,2)+z+vert(5,3)>0
                                count=count+1;
                                record(count,:)=[x,y,z];
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
p=randperm(count);
p1=p(1:nprocess);
point=zeros(nprocess,3);
point=record(p1,:);
save('point/point_3','record');

%shape_4
v1=[25,25,45];
v2=[25,25,10];
v3=[12.01,32.5,25];
v4=[25,10,25];
v5=[37.99,32.5,25];
vert=zeros(6,3);
S=solve(v1(1)*A+v1(2)*B+v1(3)+D==0,v3(1)*A+v3(2)*B+v3(3)+D==0,v4(1)*A+v4(2)*B+v4(3)+D==0);
vert(1,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(v1(1)*A+v1(2)*B+v1(3)+D==0,v4(1)*A+v4(2)*B+v4(3)+D==0,v5(1)*A+v5(2)*B+v5(3)+D==0);
vert(2,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(v1(1)*A+v1(2)*B+v1(3)+D==0,v3(1)*A+v3(2)*B+v3(3)+D==0,v5(1)*A+v5(2)*B+v5(3)+D==0);
vert(3,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(v2(1)*A+v2(2)*B+v2(3)+D==0,v3(1)*A+v3(2)*B+v3(3)+D==0,v4(1)*A+v4(2)*B+v4(3)+D==0);
vert(4,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(v2(1)*A+v2(2)*B+v2(3)+D==0,v4(1)*A+v4(2)*B+v4(3)+D==0,v5(1)*A+v5(2)*B+v5(3)+D==0);
vert(5,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(v2(1)*A+v2(2)*B+v2(3)+D==0,v3(1)*A+v3(2)*B+v3(3)+D==0,v5(1)*A+v5(2)*B+v5(3)+D==0);
vert(6,:)=[double(S.A),double(S.B),double(S.D)];

count=0;
record=zeros(1,3);
for x=1:50;
    for y=1:50
        for z=1:50
            if (x-25)^2+(y-25)^2+(z-25)^2>6.5^2
                if x*vert(1,1)+y*vert(1,2)+z+vert(1,3)<=0
                    if x*vert(2,1)+y*vert(2,2)+z+vert(2,3)<=0
                        if x*vert(3,1)+y*vert(3,2)+z+vert(3,3)<=0
                            if x*vert(4,1)+y*vert(4,2)+z+vert(4,3)>=0
                                if x*vert(5,1)+y*vert(5,2)+z+vert(5,3)>=0
                                    if x*vert(6,1)+y*vert(6,2)+z+vert(6,3)>=0
                                count=count+1;
                                record(count,:)=[x,y,z];
                                    end
                                
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

p=randperm(count);
p1=p(1:nprocess);
point=zeros(nprocess,3);
point=record(p1,:);
save('point/point_4','record');

%shape5
v1=[25,25,40];
v2=[25,25,10];
v3=[25,40,25];
v4=[10,25,25];
v5=[25,10,25];
v6=[40,25,25];
vert=zeros(8,3);
S=solve(v1(1)*A+v1(2)*B+v1(3)+D==0,v3(1)*A+v3(2)*B+v3(3)+D==0,v4(1)*A+v4(2)*B+v4(3)+D==0);
vert(1,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(v1(1)*A+v1(2)*B+v1(3)+D==0,v4(1)*A+v4(2)*B+v4(3)+D==0,v5(1)*A+v5(2)*B+v5(3)+D==0);
vert(2,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(v1(1)*A+v1(2)*B+v1(3)+D==0,v5(1)*A+v5(2)*B+v5(3)+D==0,v6(1)*A+v6(2)*B+v6(3)+D==0);
vert(3,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(v1(1)*A+v1(2)*B+v1(3)+D==0,v3(1)*A+v3(2)*B+v3(3)+D==0,v6(1)*A+v6(2)*B+v6(3)+D==0);
vert(4,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(v2(1)*A+v2(2)*B+v2(3)+D==0,v3(1)*A+v3(2)*B+v3(3)+D==0,v4(1)*A+v4(2)*B+v4(3)+D==0);
vert(5,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(v2(1)*A+v2(2)*B+v2(3)+D==0,v4(1)*A+v4(2)*B+v4(3)+D==0,v5(1)*A+v5(2)*B+v5(3)+D==0);
vert(6,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(v2(1)*A+v2(2)*B+v2(3)+D==0,v5(1)*A+v5(2)*B+v5(3)+D==0,v6(1)*A+v6(2)*B+v6(3)+D==0);
vert(7,:)=[double(S.A),double(S.B),double(S.D)];
S=solve(v2(1)*A+v2(2)*B+v2(3)+D==0,v3(1)*A+v3(2)*B+v3(3)+D==0,v6(1)*A+v6(2)*B+v6(3)+D==0);
vert(8,:)=[double(S.A),double(S.B),double(S.D)];

count=0;
record=zeros(1,3);
for x=1:50;
    for y=1:50
        for z=1:50
            if (x-25)^2+(y-25)^2+(z-25)^2>6.5^2
                if x*vert(1,1)+y*vert(1,2)+z+vert(1,3)<=0
                    if x*vert(2,1)+y*vert(2,2)+z+vert(2,3)<=0
                        if x*vert(3,1)+y*vert(3,2)+z+vert(3,3)<=0
                            if x*vert(4,1)+y*vert(4,2)+z+vert(4,3)<=0
                                if x*vert(5,1)+y*vert(5,2)+z+vert(5,3)>=0
                                    if x*vert(6,1)+y*vert(6,2)+z+vert(6,3)>=0
                                        if x*vert(7,1)+y*vert(7,2)+z+vert(7,3)>=0
                                            if x*vert(8,1)+y*vert(8,2)+z+vert(8,3)>=0
                                count=count+1;
                                record(count,:)=[x,y,z];
                                            end
                                        end
                                    end
                               
                                
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

p=randperm(count);
p1=p(1:nprocess);
point=zeros(nprocess,3);
point=record(p1,:);
save('point/point_5','record');

%shape 6 
record=zeros(1,3);
count=0;
for x=1:50
    for y=1:50
        for z=1:50
            if (x-25)^2+(y-25)^2+(z-25)^2>6.5^2
                if (x-25)^2+(y-25)^2+(z-25)^2/4<13^2
                    count=count+1;
                    record(count,:)=[x,y,z];
                end
            end
        end
    end
end
p=randperm(count);
p1=p(1:nprocess);
point=zeros(nprocess,3);
point=record(p1,:);
save('point/point_6','record');

%shape 7
point_1=zeros(25,3);
point_1(:,1)=1:25;
point_1(:,2)=25;
point_1(:,3)=25;
point_2=zeros(25,3);
point_2(:,1)=26:50;
point_2(:,2)=25;
point_2(:,3)=25;
point_3=zeros(25,3);
point_3(:,1)=25;
point_3(:,2)=1:25;
point_3(:,3)=25;
point_4=zeros(25,3);
point_4(:,1)=25;
point_4(:,2)=26:50;
point_4(:,3)=25;
point_5=zeros(25,3);
point_5(:,1)=25;
point_5(:,2)=25;
point_5(:,3)=1:25;
point_6=zeros(25,3);
point_6(:,1)=25;
point_6(:,2)=25;
point_6(:,3)=26:50;
point_1=[point_1;point_2];
point_2=[point_3;point_4];
point_3=[point_5;point_6];
point_4=(point_1+point_2)/2;
point_5=(point_1+point_3)/2;
point_6=(point_2+point_3)/2;
point=[point_1;point_2;point_3;point_4;point_5;point_6];
point_7=(point_4+point_5)/2;
point_8=(point_4+point_6)/2;
point_9=(point_5+point_6)/2;
point=[point;point_7;point_8;point_9];
point_10=(point_6+point_9)/2;
point_11=(point_1+point_5)/2;
point=[point;point_10;point_11];
point=round(point);

record=zeros(1,3);
count=0;
for num=1:80
a=rand;b=rand;c=rand;
x=1:50;
y=(b/a)*(x-25)+25;
z=(c/a)*(x-25)+25;
    for n=1:50
        if round(y(n))<=50 && round(z(n))<=50 && round(y(n))>0 && round(z(n))>0
            if (x(n)-25)^2+(y(n)-25)^2+(z(n)-25)^2>6.5^2
                s=size(record);
                cn=0;
                for k=1:s(1)
                    if (sum(record(k,:)==[x(n),round(y(n)),round(z(n))])==3)
                        cn=cn+1;
                    end
                end
                if cn==0
                    count=count+1;
                    record(count,:)=[round(x(n)),round(y(n)),round(z(n))];
                end
            end
        end
    end
end

p=randperm(count);
p1=p(1:nprocess);
point=zeros(nprocess,3);
point=record(p1,:);
save('point/point_7','record');

%shape 8
record=zeros(1,3);
count=0;
for num=1:80
a=rand*2-1;b=rand*2-1;c=rand*2-1;
x=1:50;
y=(b/a)*(x-25)+25;
z=(c/a)*(x-25)+25;
    for n=1:50
        if round(y(n))<50 && round(z(n))<50 && round(y(n))>0 && round(z(n))>0
            if (x(n)-25)^2+(y(n)-25)^2+(z(n)-25)^2>6.5^2
                s=size(record);
                cn=0;
                for k=1:s(1)
                    if (sum(record(k,:)==[x(n),round(y(n)),round(z(n))])==3)
                        cn=cn+1;
                    end
                end
                if cn==0
                    count=count+1;
                    record(count,:)=[round(x(n)),round(y(n)),round(z(n))];
                end
            end
        end
    end
end

p=randperm(count);
p1=p(1:nprocess);
point=zeros(nprocess,3);
point=record(p1,:);
save('point/point_8','record');

%shape 9

record=zeros(1,3);
count=0;
for x=1:50
    for y=20:30
        for z=1:50
            if (x-25)^2+(y-25)^2+(z-25)^2>6.5^2
                if z>4*sin(x*1/16*pi)+15 && z<4*sin(x*1/16*pi)+40
                    count=count+1;
                    record(count,:)=[x,y,z];
                end
            end
        end
    end
end

p=randperm(count);
p1=p(1:nprocess);
point=zeros(nprocess,3);
point=record(p1,:);                   
save('point/point_9','record');         

%shape 10
record=zeros(1,3);
count=0;
for x=10:40
    for y=10:40
        for z=1:50
            if (x-25)^2+(y-25)^2+(z-25)^2>6.5^2
                if z>sqrt((x-25)^2+(y-25)^2)+10 && z<sqrt((x-25)^2+(y-25)^2)+30
                    count=count+1;
                    record(count,:)=[x,y,z];
                end
            end
        end
    end
end
p=randperm(count);
p1=p(1:nprocess);
point=zeros(nprocess,3);
point=record(p1,:);                   
save('point/point_10','record');   

%shape 11
record=zeros(1,3);
count=0;
for x=10:40
    for y=10:40
        for z=1:50
            if (x-25)^2+(y-25)^2+(z-25)^2>6.5^2
                if x^2+y^2+z^2>40^2 && (x-50)^2+(y-50)^2+(z-50)^2>40^2
                    count=count+1;
                    record(count,:)=[x,y,z];
                end
            end
        end
    end
end

p=randperm(count);
p1=p(1:nprocess);
point=zeros(nprocess,3);
point=record(p1,:);      
save('point/point_11','record');

%shape 12 爱心
x=-5:0.1:5;
y=-5:0.1:5;
z=-5:0.1:5;
(x^2+9/4*y^2+z^2-1)^3-x^2*z^3-9/80*y^2*z^3==0;

[x,y,z]=meshgrid(linspace(-10,10)); 
val=(x.^2 + (9/4)*y.^2 + z.^2 - 1).^3 - x.^2.*z.^3 - (1/9)*y.^2.*z.^3; 
isosurface(x,y,z,val,0); 
axis equal;view(-10,24);colormap([1 0.2 0.2])

record=zeros(1,3);
count=0;
for x=1:50
    for y=1:50
        for z=1:50
            if (x-25)^2+(y-25)^2+(z-25)^2>6.5^2
                if ((x-25)^2/100+9/400*(y-25)^2+(z-15)^2/100-1)^3-(x-25)^2/100*(z-15)^3/100-9/80*(y-25)^2*(z-15)^3/10000<0
                    count=count+1;
                    record(count,:)=[x,y,z];
                end
            end
        end
    end
end

p=randperm(count);
p1=p(1:nprocess);
point=zeros(nprocess,3);
point=record(p1,:);      
save('point/point_12','record');

%shape 13 圆柱
record=zeros(1,3);
count=0;
for x=1:50
    for y=1:50
        for z=10:40
            if (x-25)^2+(y-25)^2+(z-25)^2>6.5^2
                if (x-25)^2+(y-25)^2<12^2
                    count=count+1;
                    record(count,:)=[x,y,z];
                end
            end
        end
    end
end

p=randperm(count);
p1=p(1:nprocess);
point=zeros(nprocess,3);
point=record(p1,:);      
save('point/point_13','record');

%shape 14 圆锥
record=zeros(1,3);
count=0;
for x=1:50
    for y=1:50
        for z=20:50
            if (x-25)^2+(y-25)^2+(z-25)^2>6.5^2
                if (x-25)^2+(y-25)^2<=((1-(z-20)/30)*15)^2
                    count=count+1;
                    record(count,:)=[x,y,z];
                end
            end
        end
    end
end
p=randperm(count);
p1=p(1:nprocess);
point=zeros(nprocess,3);
point=record(p1,:);      
save('point/point_14','record');

%shape 15 双面圆锥
record=zeros(1,3);
count=0;
for x=1:50
    for y=1:50
        for z=25:40
            if (x-25)^2+(y-25)^2+(z-25)^2>6.5^2
                if (x-25)^2+(y-25)^2<=((1-(z-25)/15)*15)^2
                    count=count+1;
                    record(count,:)=[x,y,z];
                end
            end
        end
    end
end
for x=1:50
    for y=1:50
        for z=10:25
            if (x-25)^2+(y-25)^2+(z-25)^2>6.5^2
                if (x-25)^2+(y-25)^2<=((1-(25-z)/15)*15)^2
                    count=count+1;
                    record(count,:)=[x,y,z];
                end
            end
        end
    end
end
p=randperm(count);
p1=p(1:nprocess);
point=zeros(nprocess,3);
point=record(p1,:);      
save('point/point_15','record');
