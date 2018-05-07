n1=800;n2=12;n3=12;nprocess=1837;nrna=175;rrna=6.5;inteval=8;iter=40;ratio=12;
number_shape=24;
pnum1=7;pnum2=25;

record_file=fopen('shape_new_right/linear_1.txt','wt');
for repeat=1:2
record=zeros(nprocess,6);
count1=0;
for xx=1:n1
    for yy=1:n2
        for zz=1:n3
            if (yy-n2/2)^2+(zz-n3/2)^2>2^2
               count1=count1+1;
               record(count1,1:3)=[xx,yy,zz];
            end
        end
    end
end            

p=randperm(count1);
p1=p(1:nprocess);
randomFactor=zeros(nprocess,7);
randomFactor(:,2:4)=record(p1,1:3);

inner=zeros(nrna,4);
count3=0;
for n=200:600
    if rem(n,2)==0
        count3=count3+1;
        inner(count3,1)=n;
        inner(count3,2)=n2/2;
        inner(count3,3)=n3/2;
    end
end

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
[randomFactor_res]=CalEffect_all_linear(randomFactor,inner,n1,n2,n3);
sum(randomFactor_res(:,7))/nprocess*80
plot3(randomFactor_res(:,2),randomFactor(:,3),randomFactor(:,4),'.','color','red');
hold on;
plot3(inner(:,1),inner(:,2),inner(:,3),'.','color','black');
hold off;
%axis([0,50,0,50,0,50]);
file=['shape_new_right/effect_all_inner_linear_outer_linear_',num2str(repeat),'.txt'];
type_w=fopen(file,'wt');
for n=1:nprocess
    fprintf(type_w,'%d\t%d\t%d\t%d\t%d\t%d\n',randomFactor(n,2),randomFactor(n,3),randomFactor(n,4),randomFactor(n,5),randomFactor(n,6),randomFactor_res(n,7)*(60));
end
fprintf(record_file,'%d\n',sum(randomFactor_res(:,7))/nprocess*80);
end
fclose('all');

a=load('shape_new_right/linear_1.txt');
max(a)

%{
type_w=fopen('model_res/inner_point.txt','wt');
for n=1:nrna
    fprintf(type_w,'%d\t%d\t%d\n',inner(n,1),inner(n,2),inner(n,3));
end
%}