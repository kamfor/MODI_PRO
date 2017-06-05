%% inicjalizacja
clear all; 
x0=10;
y0=10;
width=1000;
height=800;
fid = fopen('bledy_dyn','w+'); 
%% import danych
ucz = importdata('danedynucz9.txt');
u_ucz = ucz(:,1);
y_ucz = ucz(:,2);
wer = importdata('danedynwer9.txt');
u_wer = wer(:,1);
y_wer = wer(:,2);
lenght=size(wer);
P = lenght(1); %liczba próbek
kk = 1:P;
%% Modele o różnych stopniach wielomianu

k_pocz = 4; % chwila, od której rozpoczynamy identyfikacje

        ymod_ucz = zeros(P,1);
        ymod_wer = zeros(P,1);
        Y = y_ucz(k_pocz:P);
        ymod_ucz(1:k_pocz) = y_ucz(1:k_pocz);
        ymod_wer(1:k_pocz) = y_wer(1:k_pocz);
        D = 3; 



        %uczenie modelu
             
        M(:,:)= [u_ucz(k_pocz-1:P-1) u_ucz(k_pocz-2:P-2) u_ucz(k_pocz-3:P-3) y_ucz(k_pocz-1:P-1) y_ucz(k_pocz-2:P-2) y_ucz(k_pocz-3:P-3)];

        w=M\Y;
        
        %rekurencyjnie
        
        ymod_ucz = zeros(P-D,1);
        ymod_wer = zeros(P-D,1); 
        
        ymod_ucz(1:D) = u_ucz(1:D);
        ymod_wer(1:D) = y_wer(1:D);

        past_ucz = zeros(D,1);
        past_wer = zeros(D,1);
        
        for k=D+1:P
 
            m_ucz(1,:) = [u_ucz(k-1) u_ucz(k-2) u_ucz(k-3) past_ucz(1) past_ucz(2) past_ucz(3)];
            m_wer(1,:) = [u_wer(k-1) u_wer(k-2) u_wer(k-3) past_wer(1) past_wer(2) past_wer(3)];
            
            ymod_ucz(k)=m_ucz*w;
            ymod_wer(k)=m_wer*w;
            past_ucz = [ymod_ucz(k);past_ucz((1:numel(past_ucz)-1))];
            past_wer = [ymod_wer(k);past_wer((1:numel(past_wer)-1))];
        end
        
         h = figure;
        set(h,'units','points','position',[x0,y0,width,height]);
        subplot(2,1,1)
        plot(kk,y_ucz)
        ylim([-10 10])
        hold on
        plot(kk,ymod_ucz,'g')
        ylim([-10 10])
        title('y_{ucz}(k)');
        subplot(2,1,2);
        plot(kk,y_wer)
        ylim([-10 10])
        hold on
        plot(kk,ymod_wer,'g')
        ylim([-10 10])
        title('y_{wer}(k)');
        name =  ['dane_dyn_mod_rek_napalowo_D_' num2str(D) 'N_' num2str(N) '.png'];
        saveas(h,name,'png');
