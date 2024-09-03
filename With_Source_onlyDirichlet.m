clear all
close all
clc

%numerical analysis
length = input("Enter length of rod: ");
l = input("Enter number of points: ");
val = length/(l-1);
A = zeros(l,l);
for i = 1:l
    for j = 1:l
        if ((i==1)&&(j==1))||((i==l)&&(j==l))
            A(i,j)=1;
        else
            if(i==j)
                A(i,j)=-2;
            elseif((j==i-1)||(j==i+1))&&((i~=1)&&(i~=l))
                A(i,j)=1;
            end

        end
    end
end
delx = zeros(l-1,1);

choice1 = input("Enter 1 for uniform grid size, 2 for non uniform grid size: ");
if choice1 == 1
   for i = 1:l-1
     delx(i) = val;
   end
else 
   for i = 1:l-1
     delx(i) = input("Enter interval values: ");
   end
end

qdot_k = input("Enter source magnitude by K value: ");
%disp(delx);
lenarr = zeros(l,1);
sum1 = 0;
for i = 1:(l-1)
    lenarr(i) = sum1;
    sum1 = sum1 + delx(i);
end
lenarr(l) = sum1;
%disp(lenarr);
R = zeros(l,1);

temp_A = input("Enter temp of leftend: ");
temp_B = input("Enter temp of rightend: ");
R(1) = temp_A;
R(l) = temp_B;
for i=2:(l-1)
    R(i) = -qdot_k*(delx(i-1))^2;
end
%disp(R);
Temp = A\R;
%disp(Temp);

%theoretical profile
c1 = (temp_B - temp_A)/length + qdot_k*length/2;
th_temp = [];
x_dist = [];
for x = 0:0.0001:length 
   x_dist = [x_dist;x];
   temp_th_val = -qdot_k*(x^2)/2 + c1*x + temp_A;
   th_temp = [th_temp;temp_th_val];
end

figure(1)
plot(x_dist,th_temp);
hold on
plot(lenarr,Temp);
hold off