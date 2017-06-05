%% inicjalizacja
clear all; 
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
k_pocz = 5; % chwila, od której rozpoczynamy identyfikacje

%% Modele o wyrazach mieszanych 
for s=4:4
    D = s; 
    for t=4:4
        N = t; 
        ymod_ucz = zeros(P,1);
        ymod_wer = zeros(P,1);
        Y = y_ucz(k_pocz:P);
        
        %uczenie modelu
        c=1;
        for i=1:D         
            for j=1:N
                Mu(:,c)= u_ucz(k_pocz-i:P-i).^j;
                My(:,c)=y_ucz(k_pocz-i:P-i).^j;
                c=c+1;
            end
        end
        Mm1(:,:)= [u_ucz(k_pocz-1:P-1).*y_ucz(k_pocz-1:P-1) u_ucz(k_pocz-2:P-2).*y_ucz(k_pocz-2:P-2) u_ucz(k_pocz-3:P-3).*y_ucz(k_pocz-3:P-3) u_ucz(k_pocz-4:P-4).*y_ucz(k_pocz-4:P-4)];
        M = [Mu My Mm1]; 
        w=M\Y;
        
        %sprawdzanie modelu z rekurencja
        
        ymod_ucz = zeros(P-D,1);
        ymod_wer = zeros(P-D,1);
        ymod_ucz(1:D) = u_ucz(1:D);
        ymod_wer(1:D) = y_wer(1:D);

        past_ucz = zeros(D,1);
        past_wer = zeros(D,1);
        for k=D+1:P
            c=1;
            for i=1:D
                for j=1:N
                    m_ucz_u(1,c)= u_ucz(k-i)^j;
                    m_ucz_y(1,c)=past_ucz(i)^j;
                    m_wer_u(1,c)= u_wer(k-i)^j;
                    m_wer_y(1,c)=past_wer(i)^j;
                    c=c+1;
                end
            end
            Mum1(:,:)= [u_ucz(k-1)*past_ucz(1) u_ucz(k-2)*past_ucz(2) u_ucz(k-3)*past_ucz(3) u_ucz(k-4)*past_ucz(4)];
            
            Mwm1(:,:)= [u_wer(k-1)*past_wer(1) u_wer(k-2)*past_wer(2) u_wer(k-3)*past_wer(3) u_wer(k-4)*past_wer(4)];

            m_ucz = [m_ucz_u m_ucz_y Mum1];
            m_wer = [m_wer_u m_wer_y Mwm1]; 
            ymod_ucz(k)=m_ucz*w;
            ymod_wer(k)=m_wer*w;
            past_ucz = [ymod_ucz(k);past_ucz((1:numel(past_ucz)-1))];
            past_wer = [ymod_wer(k);past_wer((1:numel(past_wer)-1))];
        end
        
        mod_statyczny = fit(u_wer,ymod_wer,'poly5');
        
        
        h = figure;
        set(h,'units','points','position',[10,10,1000,800]); 
        scatter(u_wer,ymod_wer)
        xlabel('u','FontSize',14);
        ylabel('y_{mod}','FontSize',14); 
        name =  'y(u)';
        title(name);
        hold on; 
        plot(mod_statyczny); 
        legend('y(u)','model statyczny'); 
        name =  'model_stat.png';
        saveas(h,name,'png');
        
        
    end
end