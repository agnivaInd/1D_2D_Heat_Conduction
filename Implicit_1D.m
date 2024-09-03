clear all
close all
clc

%numerical analysis
time = input("Enter total time duration: ");
time_step = input("Enter time step value: ");
no_of_steps = abs(time/time_step);
i_temp_A = input("Enter initial left hand temperature: ");
i_temp_B = input("Enter initial right hand temperature: ");
temp_A = input("Enter left side temp (boundary cond.): ");
temp_B = input("Enter right side temp (boundary cond.): ");
alpha = input("Enter alpha value: ");

%Time t=0
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

R(1) = i_temp_A;
R(l) = i_temp_B;
for i=2:(l-1)
    R(i) = -qdot_k*(delx(i-1))^2;
end
%disp(R);
Temp = A\R;
%disp(Temp);
plot(lenarr,Temp)
hold on

%Next time steps
for t = time_step:time_step:time
    store_Temp = Temp;
    R = zeros(l,1);
    R(1) = temp_A;
    R(l) = temp_B;
    A = zeros(l,l);
    for i = 1:l
        for j = 1:l
            if ((i==1)&&(j==1))||((i==l)&&(j==l))
                A(i,j)=1;
            else
                if(i==j)
                    A(i,j)=2 + (val^2)/(alpha*time_step);
                elseif((j==i-1)||(j==i+1))&&((i~=1)&&(i~=l))
                    A(i,j)=-1;
                end
            end
        end
    end
    for i=2:(l-1)
        R(i) = store_Temp(i)*(val^2/(alpha*time_step)) + qdot_k*(delx(i-1))^2;
    end
    Temp = A\R;
    %disp(Temp)
    plot(lenarr,Temp)
    hold on
end
hold off