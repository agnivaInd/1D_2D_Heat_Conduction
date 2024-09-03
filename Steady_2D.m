clear all
close all
clc

length = input("Enter side length of square plate: ");
l = input("Enter number of points: ");
val = (l-2);
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

val_temp_left = input("Enter temp of left side: ");
val_temp_right = input("Enter temp of right side: ");
val_temp_top = input("Enter temp of top side: ");
val_temp_bottom = input("Enter temp of bottom side: ");
temp_left = zeros(val,1);
temp_right = zeros(val,1);
temp_top = zeros(val,1);
temp_bottom = zeros(val,1);

for i = 1:val
    temp_left(i) = val_temp_left;
    temp_right(i) = val_temp_right;
    temp_top(i) = val_temp_top;
    temp_bottom(i) = val_temp_bottom;
end

R = zeros(val^2,1);
for i = 1:(val^2)
    if i == 1
        R(i) = val_temp_bottom + val_temp_left;
    end
    if (i>1)&&(i<val)
        R(i) = val_temp_bottom;
    end    
    if i == val
        R(i) = val_temp_bottom + val_temp_right;
    end
    if (rem(i,val)==0)&&(i~=val)
        R(i) = val_temp_right;
    end
    if (rem(i,val)==1)&&(i~=1)
        R(i) = val_temp_left;
    end    
    if i == val^2-val+1
        R(i) = val_temp_top + val_temp_left;
    end
    if (i>(val^2-val+1))&&(i<val^2)
        R(i) = val_temp_top;
    end    
    if i == val^2
        R(i) = val_temp_top + val_temp_right;
    end
end
%disp(R);

Temp = A\R;
%disp(Temp)

disp_Temp = zeros(val,val);
c = 1;
for i = 1:val
    for j = 1:val
        disp_Temp(val+1-i,j) = Temp(c);
        c = c + 1;
    end
end

disp(disp_Temp);