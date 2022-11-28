clc
clear all
I= imread('peppers.png');
[m,n,d]=size(I);
if(d==3)
    I=rgb2gray(I);
end
IN = imnoise(I,'salt & pepper',0.2);
E= padarray(IN,[2 2],'replicate');
[M,N,D]=size(E);
%corrupting image with salt and pepper noise 
J=IN;
figure,
imshow(J)
title("Image corrupted with Salt and pepper noise with 10% density")
%noise detection                                                                            
R=zeros(size(M,N));
for i=3:M-2
    for j=3:N-2
        if E(i,j)==0 || E(i,j)==255
            R(i,j)=1;
        end
    end
end
for i=3:M-2
    for j=3:N-2
        n0=0;
        n255=0;
        if R(i,j)==1
            for p=i-2:i+2
                for q=j-2:j+2
                    if E(p,q)==0
                        n0=n0+1;
                    elseif E(p,q)==255
                            n255=n255+1;
                    end
                end
            end
            if((E(i,j)==0 && n0>(25-n0)) || (E(i,j)==255 && n255>(25-n255)))
                R(i,j)=0;
            end
        end
    end
end
R1= padarray(R,[1,1],'both');
R2=padarray(R1,[2,2],"both");
R3=padarray(R2,[2,2],"both");
%salt and pepper noise removal
c=0;
%A=zeros(5,5,'uint8');
for i=3:M-2
    for j=3:N-2
        
        c=0;
        if (R(i,j)==1)
            for p=i-2:i+2
                for q=j-2:j+2
                    if E(p,q)~=0 && E(p,q)~=255
                        c=c+1;
                    end
                end
            end
            T=c/4;
            A=E(i-2:i+2,j-2:j+2);
            B=reshape(A.',1,[]);
            [D,F]=mode(B,'all');
            if (F>=T)
                J(i-2,j-2)=D;
            else
                J(i-2,j-2)=median(B,'all');
            end
        end
    end
end
figure,
imshow(J)
title("Denoised image with window K=5")
mse(I,J)
% 7 Window
E1= padarray(J,[3,3],'replicate');
[x,y,~]=size(E1);
for i=4:x-3
    for j=4:y-3
        c=0;
        if (R1(i,j)==1)
            for p=i-3:i+3
                for q=j-3:j+3
                    if E1(p,q)~=0 && E1(p,q)~=255
                        c=c+1;
                    end
                end
            end
            T=c/4;
            A=E1(i-3:i+3,j-3:j+3);
            B=reshape(A.',1,[]);
            [D,F]=mode(B,'all');
            if (F>=T)
                J(i-3,j-3)=D;
            else
                J(i-3,j-3)=median(B,'all');
            end
        end
    end
end
figure,
imshow(J)
title("Denoised image with window K=7")
mse(I,J)
% 9 Window
E2= padarray(J,[4,4],'replicate');
[a,b,~]=size(E2);
for i=5:a-4
    for j=5:b-4
        c=0;
        if (R2(i,j)==1)
            for p=i-4:i+4
                for q=j-4:j+4
                    if E2(p,q)~=0 && E2(p,q)~=255
                        c=c+1;
                    end
                end
            end
            T=c/4;
            A=E2(i-4:i+4,j-4:j+4);
            B=reshape(A.',1,[]);
            [D,F]=mode(B,'all');
            if (F>=T)
                J(i-4,j-4)=D;
            else
                J(i-4,j-4)=median(B,'all');
            end
        end
    end
end
figure,
imshow(J)
title("Denoised image with window K=9")
mse(I,J)
% 11 Window
E3= padarray(J,[5,5],'replicate');
[u,v,~]=size(E3);
for i=6:u-5
    for j=6:v-5
        c=0;
        if (R3(i,j)==1)
            for p=i-5:i+5
                for q=j-5:j+5
                    if E3(p,q)~=0 && E3(p,q)~=255
                        c=c+1;
                    end
                end
            end
            T=c/4;
            A=E3(i-5:i+5,j-5:j+5);
            B=reshape(A.',1,[]);
            [D,F]=mode(B,'all');
            if (F>=T)
                J(i-5,j-5)=D;
            else
                J(i-5,j-5)=median(B,'all');
            end
        end
    end
end
figure,
imshow(J)
title("Denoised image with window K=11")
mse(I,J)