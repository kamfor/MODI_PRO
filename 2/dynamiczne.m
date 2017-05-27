clear all;
%% inicjalizacja
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
% %% wykresy danych dynamicznych
% k = 1:P;
% h = figure;
% set(h,'units','points','position',[x0,y0,width,height]); 
% subplot(2,1,1)
% plot(k,u_ucz)
% title('u_{ucz}(k)');
% subplot(2,1,2);
% plot(k,y_ucz)
% title('y_{ucz}(k)');
% name =  'dane_dyn_ucz.png';
% saveas(h,name,'png');
% 
% h = figure;
% set(h,'units','points','position',[x0,y0,width,height]); 
% subplot(2,1,1)
% plot(k,u_wer)
% title('u_{wer}(k)');
% subplot(2,1,2);
% plot(k,y_wer)
% title('y_{wer}(k)');
% name =  'dane_dyn_wer.png';
% saveas(h,name,'png');
% 
% %% dynamiczne modele stopnia 1,2,3 z rekurencją i bez rekurancji 
% 
% k_pocz = 6; % chwila, od której rozpoczynamy identyfikacje
% 
% 
% for l=1:3
%     
%     ymod_ucz = zeros(P,1);
%     ymod_wer = zeros(P,1);
%     Y = y_ucz(k_pocz:P);
%     ymod_ucz(1:k_pocz) = y_ucz(1:k_pocz);
%     ymod_wer(1:k_pocz) = y_wer(1:k_pocz);
% 
%     % uczenie modelu
%     c=1; %kolumna
%     for i=1:l         
%            M(:,c)=u_ucz(k_pocz-i:P-i);
%            M(:,c+2)=y_ucz(k_pocz-i:P-i);
%            c=c+1;
%     end
%     w=M\Y;
% 
%     % sprawdzenie modelu
%     % bez rekurencji
%     c=1;
%     for  i=1:l        
%         mb_wer(:,c)= u_wer(k_pocz-i:P-i);
%         mb_wer(:,c+2)=y_wer(k_pocz-i:P-i);
%         c=c+1;
%     end
%     ymod_ucz(k_pocz:P)=M*w;
%     ymod_wer(k_pocz:P)=mb_wer*w;
%     
%     % wykresy danych i modelu
%     h = figure;
%     set(h,'units','points','position',[x0,y0,width,height]); 
%     subplot(2,1,1)
%     plot(kk,y_ucz)
%     hold on
%     plot(kk,ymod_ucz,'g')
%     title('y_{ucz}(k)');
%     subplot(2,1,2);
%     plot(kk,y_wer)
%     hold on
%     plot(kk,ymod_wer,'g')
%     title('y_{wer}(k)');
%     name =  ['dane_dyn_mod_brek_D_' num2str(l) '.png'];
%     saveas(h,name,'png');
% 
%     % bledy modelu
%     E_ucz = 0;
%     E_wer = 0;
%     for k=k_pocz:P
%        E_ucz = E_ucz + (ymod_ucz(k)-y_ucz(k))^2; 
%        E_wer = E_wer + (ymod_wer(k)-y_wer(k))^2;  
%     end
% 
%     fprintf(fid,'dane_ucz_brek_D=%d, %d \n',l,E_ucz);
%     fprintf(fid,'dane_wer_brek_D=%d, %d \n',l,E_wer);
% 
%     % z rekurencja
%     
%     ymod_ucz = zeros(P,1);
%     ymod_wer = zeros(P,1);
%     ymod_ucz(1:k_pocz) = y_ucz(1:k_pocz);
%     ymod_wer(1:k_pocz) = y_wer(1:k_pocz);
%     past_ucz = zeros(l,1);
%     past_wer = zeros(l,1);
%     m_wer = zeros(); 
%     
%     for k=l+1:P
%         c=1;
%         for i=1:l       
%             m_ucz(1,c)= u_ucz(k-i);
%             m_ucz(1,c+2)=past_ucz(i);
%             m_wer(1,c)= u_wer(k-i);
%             m_wer(1,c+2)=past_wer(i);
%             c=c+1;
%         end
%         ymod_ucz(k)=m_ucz*w;
%         ymod_wer(k)=m_wer*w;
%         past_ucz = [ymod_ucz(k);past_ucz((1:end-1))];
%         past_wer = [ymod_wer(k);past_wer((1:end-1))];
%     end
%     
%     % wykresy danych i modelu
%     h = figure;
%     set(h,'units','points','position',[x0,y0,width,height]); 
%     subplot(2,1,1)
%     plot(kk,y_ucz)
%     hold on
%     plot(kk,ymod_ucz,'g')
%     title('y_{ucz}(k)');
%     subplot(2,1,2);
%     plot(kk,y_wer)
%     hold on
%     plot(kk,ymod_wer,'g')
%     title('y_{wer}(k)');
%     name =  ['dane_dyn_mod_rek_D_' num2str(l) '.png'];
%     saveas(h,name,'png');
% 
%     % bledy modelu
%     E_ucz = 0;
%     E_wer = 0;
%     for k=k_pocz:P
%        E_ucz = E_ucz + (ymod_ucz(k)-y_ucz(k))^2; 
%        E_wer = E_wer + (ymod_wer(k)-y_wer(k))^2;  
%     end
% 
%     fprintf(fid,'dane_ucz_rek_D=%d, %d \n',l,E_ucz);
%     fprintf(fid,'dane_wer_rek_D=%d, %d \n',l,E_wer);
% 
% end


%% Modele o różnych stopniach wielomianu
k_pocz = 4; % chwila, od której rozpoczynamy identyfikacje

for s=1:3
    D = s; 
    for t=1:4
        N = t; 
        ymod_ucz = zeros(P,1);
        ymod_wer = zeros(P,1);
        Y = y_ucz(k_pocz:P);
        ymod_ucz(1:k_pocz) = y_ucz(1:k_pocz);
        ymod_wer(1:k_pocz) = y_wer(1:k_pocz);
        


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
        c=1;
        for  i=1:D        
            for j=1:N
                mb_wer(:,c)= u_wer(k_pocz-i:P-i).^j;
                mb_wer(:,c+(N*2))=y_wer(k_pocz-i:P-i).^j;
                c=c+1;
            end
        end
        ymod_ucz(k_pocz:P)=M*w;
        ymod_wer(k_pocz:P)=mb_wer*w;
                
        h = figure;
        set(h,'units','points','position',[x0,y0,width,height]); 
        subplot(2,1,1)
        plot(kk,y_ucz)
        hold on
        plot(kk,ymod_ucz,'g')
        title('y_{ucz}(k)');
        subplot(2,1,2);
        plot(kk,y_wer)
        hold on
        plot(kk,ymod_wer,'g')
        title('y_{wer}(k)');
        name =  ['dane_dyn_mod_brek_D_' num2str(D) 'N_' num2str(N) '.png'];
        saveas(h,name,'png');
        
        E_ucz = 0;
        E_wer = 0;
        for k=k_pocz:P
            E_ucz = E_ucz + (ymod_ucz(k)-y_ucz(k))^2; 
            E_wer = E_wer + (ymod_wer(k)-y_wer(k))^2;  
        end

        fprintf(fid,'dane_ucz_brek_D=%d_N=%d, %d \n',D,N,E_ucz);
        fprintf(fid,'dane_wer_brek_D=%d_N=%d, %d \n',D,N,E_wer);

        % z rekurencja
        
        ymod_ucz = zeros(P,1);
        ymod_wer = zeros(P,1);
        past_ucz = zeros(D,1);
        past_wer = zeros(D,1);

    
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
            past_ucz = [ymod_ucz(k);past_ucz((1:end-1))];
            past_wer = [ymod_wer(k);past_wer((1:end-1))];
        end
        
        h = figure;
        set(h,'units','points','position',[x0,y0,width,height]);
        subplot(2,1,1)
        plot(kk,y_ucz)
        hold on
        plot(kk,ymod_ucz,'g')
        title('y_{ucz}(k)');
        subplot(2,1,2);
        plot(kk,y_wer)
        hold on
        plot(kk,ymod_wer,'g')
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

%% modele dynamiczne wyrazy mieszane 4 zrobimy druggiego i trzeciego stopnia z pierwszym i drugim rzędem dynamiki 
        
%         ymod_ucz = zeros(P,1);
%         ymod_wer = zeros(P,1);
%         Y = y_ucz(k_pocz:P);
%         ymod_ucz(1:k_pocz) = y_ucz(1:k_pocz);
%         ymod_wer(1:k_pocz) = y_wer(1:k_pocz);
%         
% 
%         % uczenie modelu
%         c=1; %kolumna
%         for i=1:D         
%             for j=1:N
%                 % ręcznie to wypełnij tak jak ławryn
%                 M(:,c)= u_ucz(k_pocz-i:P-i).^j;
%                 M(:,c+N*2)=y_ucz(k_pocz-i:P-i).^j;
%                 c=c+1;
%             end
%         end
%         M(:,:) = [u_ucz(k_pocz:P) y_ucz(k_pocz:P) 
%         w=M\Y;


fclose(fid);