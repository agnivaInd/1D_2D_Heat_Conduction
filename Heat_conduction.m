clear all
close all
clc

l = input("Enter number of points: ");
A = zeros(l,l);
rl = input("Enter rod length: ");
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
R = zeros(l,1);
R(1) = temp_A;
R(l) = temp_B;
T = A\R;
disp(T);
