clear all
close all
clc

time = input("Enter total time interval: ");
time_step = input("Enter time step value: ");
length = input("Enter side length of square plate: ");
l = input("Enter number of points: ");
delx = length/(l-1);
val = (l-2);
qdot = input("Enter volumetric heat generation: ");
k = input("Enter k value: ");
alpha = input("Enter alpha value: ");
A = zeros(val^2,val^2);

for i = 1:1:(val^2)
    for j = 1:1:(val^2)
        if i==j
            A(i,j) = 4;
        end
        if ((i>val)||(j>val))&&((i==j+val)||(j==i+val))
            A(i,j) = -1;
        end
        if((i==j+1)||(j==i+1))
            A(i,j) = -1;
        end    
        if ((j==i+1)&&(rem(i,val)==0))||((i==j+1)&&(rem(j,val)==0))
            A(i,j) = 0;
        end    
    end
end

initial_val_temp_left = input("Enter initial temp of left side: ");
initial_val_temp_right = input("Enter initial temp of right side: ");
initial_val_temp_top = input("Enter initial temp of top side: ");
initial_val_temp_bottom = input("Enter initial temp of bottom side: ");
temp_left = zeros(val,1);
temp_right = zeros(val,1);
temp_top = zeros(val,1);
temp_bottom = zeros(val,1);


for i = 1:val
    temp_left(i) = initial_val_temp_left;
    temp_right(i) = initial_val_temp_right;
    temp_top(i) = initial_val_temp_top;
    temp_bottom(i) = initial_val_temp_bottom;
end

R = zeros(val^2,1);
for i = 1:(val^2)
    if i == 1
        R(i) = initial_val_temp_bottom + initial_val_temp_left + qdot*(delx^2)/k;
    end
    if (i>1)&&(i<val)
        R(i) = initial_val_temp_bottom + qdot*(delx^2)/k;
    end    
    if i == val
        R(i) = initial_val_temp_bottom + initial_val_temp_right + qdot*(delx^2)/k;
    end
    if (rem(i,val)==0)&&(i~=val)
        R(i) = initial_val_temp_right + qdot*(delx^2)/k;
    end
    if (rem(i,val)==1)&&(i~=1)
        R(i) = initial_val_temp_left + qdot*(delx^2)/k;
    end    
    if i == val^2-val+1
        R(i) = initial_val_temp_top + initial_val_temp_left + qdot*(delx^2)/k;
    end
    if (i>(val^2-val+1))&&(i<val^2)
        R(i) = initial_val_temp_top + qdot*(delx^2)/k;
    end    
    if i == val^2
        R(i) = initial_val_temp_top + initial_val_temp_right + qdot*(delx^2)/k;
    end
end
%disp(R);

Temp = A\R;
%disp(Temp)
real_Temp = zeros(l^2,1);
c1 = 1;
for i = 1:(l^2)
    if (i==1)||(i==l)||(i==(l^2-l+1))||(i==(l^2))
        real_Temp(i) = 0;    
    elseif (i>1)&&(i<l)
        real_Temp(i) = initial_val_temp_bottom;    
    elseif (i>(l^2-l+1))&&(i<(l^2))    
        real_Temp(i) = initial_val_temp_top;
    elseif (rem(i,l)==0)&&(i>l)
        real_Temp(i) = initial_val_temp_right;
    elseif (rem(i,l)==1)&&(i<(l^2-l+1))&&(i~=1)
        real_Temp(i) = initial_val_temp_left;
    else
        real_Temp(i) = Temp(c1);
        c1 = c1 + 1;
    end    
end

disp_Temp = zeros(l,l);
actual_Temp = zeros(l,l);
c = 1;
for i = 1:l
    for j = 1:l
        disp_Temp(l+1-i,j) = real_Temp(c);
        actual_Temp(i,j) = real_Temp(c);
        c = c + 1;
    end
end

disp(disp_Temp);
%disp(actual_Temp);

val_temp_left = input("Enter temp of left side: ");
val_temp_right = input("Enter temp of right side: ");
val_temp_top = input("Enter temp of top side: ");
val_temp_bottom = input("Enter temp of bottom side: ");

%storing_Temp_with_time = zeros((time/time_step),l,l);
%Next time steps
display_temp = zeros(l,l);
c2 = 1;
for t = time_step:time_step:time
    store_actual_Temp = actual_Temp;
    for i = 1:l
        for j = 1:l
            if ((i==1)&&(j==1))||((i==l)&&(j==1))||((i==1)&&(j==l))||((i==l)&&(j==l))
                actual_Temp(i,j) = 0;
            elseif (i==1)&&((j~=1)||(j~=l))
                actual_Temp(i,j) = val_temp_bottom;
            elseif (i==l)&&((j~=1)||(j~=l))
                actual_Temp(i,j) = val_temp_top;
            elseif (j==1)&&((i~=1)||(i~=l))
                actual_Temp(i,j) = val_temp_left;
            elseif (j==l)&&((i~=1)||(i~=l))
                actual_Temp(i,j) = val_temp_right;
            else
                actual_Temp(i,j) = (alpha*time_step)*(store_actual_Temp(i-1,j)+store_actual_Temp(i+1,j)+store_actual_Temp(i,j-1)+store_actual_Temp(i,j+1)-4*store_actual_Temp(i,j))/((delx)^2) + qdot*alpha*time_step/k + store_actual_Temp(i,j);
            end
            display_temp(l+1-i,j) = actual_Temp(i,j);
        end
    end
    if (c2~=1)
        disp(display_temp);
    end
    c2 = c2 + 1;
end    