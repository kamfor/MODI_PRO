clear all;
%% inicjalizacja
x0=10;
y0=10;
width=1000;
height=800;
%% import danych
ucz = importdata('danedynucz9.txt');
u_ucz = ucz(:,1);
y_ucz = ucz(:,2);
wer = importdata('danedynwer9.txt');
u_wer = wer(:,1);
y_wer = wer(:,2);
lenght=size(wer);
P = lenght(1); %liczba próbek
%% wykresy danych dynamicznych
k = 1:P;
h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
subplot(2,1,1)
plot(k,u_ucz)
title('u_{ucz}(k)');
subplot(2,1,2);
plot(k,y_ucz)
title('y_{ucz}(k)');
name =  'dane_dyn_ucz.png';
saveas(h,name,'png');

h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
subplot(2,1,1)
plot(k,u_wer)
title('u_{wer}(k)');
subplot(2,1,2);
plot(k,y_wer)
title('y_{wer}(k)');
name =  'dane_dyn_wer.png';
saveas(h,name,'png');

%% dynamiczne modele trzeba to tak poukładać żeby wyszło tyle modeli ile trzeba i żeby się tabelki zrobiły
N=1; %stopien wielomianu
D=3; %rzad dynamiki
k_pocz = 5; % chwila, od której rozpoczynamy identyfikacje

ymod_ucz = zeros(P,1);
ymod_wer = zeros(P,1);
Y = y_ucz(k_pocz:P);
ymod_ucz(1:k_pocz) = y_ucz(1:k_pocz);
ymod_wer(1:k_pocz) = y_wer(1:k_pocz);

mode=1;

% uczenie modelu
c=1; %kolumna
for i=1:D         
    for j=1:N
       M(:,c)= u_ucz(k_pocz-i:P-i).^j;
       M(:,c+N*2)=y_ucz(k_pocz-i:P-i).^j;
       c=c+1;
    end
end
w=M\Y;

% sprawdzenie modelu

% bez rekurencji
if mode==0 
    c=1;
     for  i=1:D        
        for j=1:N
            m_wer(:,c)= u_wer(k_pocz-i:P-i).^j;
            m_wer(:,c+N*2)=y_wer(k_pocz-i:P-i).^j;
            c=c+1;
        end
     end
    ymod_ucz(k_pocz:P)=M*w;
    ymod_wer(k_pocz:P)=m_wer*w;
end

% z rekurencja
if mode==1
   past_ucz = zeros(D,1);
   past_wer = zeros(D,1);
   for k=D+1:P
     c=1;
     for i=1:D       
        for j=1:N
            m_ucz(1,c)= u_ucz(k-i)^j;
            m_ucz(1,c+N*2)=past_ucz(i)^j;
            m_wer(1,c)= u_wer(k-i)^j;
            m_wer(1,c+N*2)=past_wer(i)^j;
            c=c+1;
        end
     end
    ymod_ucz(k)=m_ucz*w;
    ymod_wer(k)=m_wer*w;
    past_ucz = [ymod_ucz(k);past_ucz((1:end-1))];
    past_wer = [ymod_wer(k);past_wer((1:end-1))];
   end
end


%% bledy modelu
E_ucz = 0;
E_wer = 0;
for k=k_pocz:P
   E_ucz = E_ucz + (ymod_ucz(k)-y_ucz(k))^2; 
   E_wer = E_wer + (ymod_wer(k)-y_wer(k))^2;  
end
%% wykresy danych i modelu
k = 1:P;
figure('Name','Model, zbiór uczacy','NumberTitle','off');
subplot(2,1,1)
plot(k,y_ucz)
hold on
plot(k,ymod_ucz,'g')
title('y_{ucz}(k)');
subplot(2,1,2);
plot(k,y_wer)
hold on
plot(k,ymod_wer,'g')
title('y_{wer}(k)');