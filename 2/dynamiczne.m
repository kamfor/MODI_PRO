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

for s=3:3
    D = s; 
    for t=1:1
        N = t; 
        ymod_ucz = zeros(P,1);
        ymod_wer = zeros(P,1);
        Y = y_ucz(k_pocz:P);
        ymod_ucz(1:k_pocz) = y_ucz(1:k_pocz);
        ymod_wer(1:k_pocz) = y_wer(1:k_pocz);
        


        %uczenie modelu
        c=1; %kolumna
        for i=1:D         
            for j=1:N
                M(:,c)= u_ucz(k_pocz-i:P-i).^j;
                M(:,c+N*2)=y_ucz(k_pocz-i:P-i).^j;
                c=c+1;
            end
        end
        w=M\Y;

%         %sprawdzenie modelu
% 
%         bez rekurencji
%         c=1;
%         for  i=1:D        
%             for j=1:N
%                 mb_wer(:,c)= u_wer(k_pocz-i:P-i).^j;
%                 mb_wer(:,c+(N*2))=y_wer(k_pocz-i:P-i).^j;
%                 c=c+1;
%             end
%         end
%         ymod_ucz(k_pocz:P)=M*w;
%         ymod_wer(k_pocz:P)=mb_wer*w;
%                 
%         h = figure;
%         set(h,'units','points','position',[x0,y0,width,height]); 
%         subplot(2,1,1)
%         plot(kk,y_ucz)
%         ylim([-10 10])
%         hold on
%         plot(kk,ymod_ucz,'g')
%         ylim([-10 10])
%         title('y_{ucz}(k)');
%         subplot(2,1,2);
%         plot(kk,y_wer)
%         ylim([-10 10])
%         hold on
%         plot(kk,ymod_wer,'g')
%         ylim([-10 10])
%         title('y_{wer}(k)');
%         name =  ['dane_dyn_mod_brek_D_' num2str(D) 'N_' num2str(N) '.png'];
%         saveas(h,name,'png');
%         
%         E_ucz = 0;
%         E_wer = 0;
%         for k=k_pocz:P
%             E_ucz = E_ucz + (ymod_ucz(k)-y_ucz(k))^2; 
%             E_wer = E_wer + (ymod_wer(k)-y_wer(k))^2;  
%         end
% 
%         fprintf(fid,'dane_ucz_brek_D=%d_N=%d, %d \n',D,N,E_ucz);
%         fprintf(fid,'dane_wer_brek_D=%d_N=%d, %d \n',D,N,E_wer);

        % z rekurencja
        
        ymod_ucz = zeros(P-D,1);
        ymod_wer = zeros(P-D,1); % bez rekurencji
        
        ymod_ucz(1:D) = u_ucz(1:D);
        ymod_wer(1:D) = y_wer(1:D);

        past_ucz = zeros(D,1);
        past_wer = zeros(D,1);
        for k=D+1:P
            c=1;
            for i=1:D
                for j=1:N
                    m_ucz(1,c)= u_ucz(k-i)^j;
                    m_ucz(1,c+(N*2))=past_ucz(i)^j;
                    m_wer(1,c)= u_wer(k-i)^j;
                    m_wer(1,c+(N*2))=past_wer(i)^j;
                    c=c+1;
                end
            end
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
        name =  ['dane_dyn_mod_rek_D_' num2str(D) 'N_' num2str(N) '.png'];
        saveas(h,name,'png');
        
        E_ucz = 0;
        E_wer = 0;
        for k=k_pocz:P
            E_ucz = E_ucz + (ymod_ucz(k)-y_ucz(k))^2; 
            E_wer = E_wer + (ymod_wer(k)-y_wer(k))^2;  
        end

        fprintf(fid,'dane_ucz_rek_D=%d_N=%d, %d \n',D,N,E_ucz);
        fprintf(fid,'dane_wer_rek_D=%d_N=%d, %d \n',D,N,E_wer);
    end
end


fclose(fid);