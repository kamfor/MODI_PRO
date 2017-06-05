%% inicjalizacja
clear all; 
fid = fopen('bledy_dyn_miesz1','w+'); 
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
        ymod_ucz(1:k_pocz) = y_ucz(1:k_pocz);
        ymod_wer(1:k_pocz) = y_wer(1:k_pocz);
        
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
        %Mm2(:,:)= [u_ucz(k_pocz-1:P-1).^2.*y_ucz(k_pocz-1:P-1).^2 u_ucz(k_pocz-2:P-2).^2.*y_ucz(k_pocz-2:P-2).^2 u_ucz(k_pocz-3:P-3).^2.*y_ucz(k_pocz-3:P-3).^2 u_ucz(k_pocz-4:P-4).^2.*y_ucz(k_pocz-4:P-4).^2];
        %Mm3(:,:)= [u_ucz(k_pocz-1:P-1).^3.*y_ucz(k_pocz-1:P-1).^3 u_ucz(k_pocz-2:P-2).^3.*y_ucz(k_pocz-2:P-2).^3 u_ucz(k_pocz-3:P-3).^3.*y_ucz(k_pocz-3:P-3).^3 u_ucz(k_pocz-4:P-4).^3.*y_ucz(k_pocz-4:P-4).^3];
        %Mm4(:,:)= [u_ucz(k_pocz-1:P-1).^4.*y_ucz(k_pocz-1:P-1).^4 u_ucz(k_pocz-2:P-2).^4.*y_ucz(k_pocz-2:P-2).^4 u_ucz(k_pocz-3:P-3).^4.*y_ucz(k_pocz-3:P-3).^2 u_ucz(k_pocz-4:P-4).^4.*y_ucz(k_pocz-4:P-4).^4];
        M = [Mu My Mm1]; 
        w=M\Y;

        %sprawdzenie modelu bez rekurencji
        c=1;
        for  i=1:D        
            for j=1:N
                mb_wer_u(:,c)=u_wer(k_pocz-i:P-i).^j;
                mb_wer_y(:,c)=y_wer(k_pocz-i:P-i).^j;
                c=c+1;
            end
        end
        Mbm1(:,:)= [u_wer(k_pocz-1:P-1).*y_wer(k_pocz-1:P-1) u_wer(k_pocz-2:P-2).*y_wer(k_pocz-2:P-2) u_wer(k_pocz-3:P-3).*y_wer(k_pocz-3:P-3) u_wer(k_pocz-4:P-4).*y_wer(k_pocz-4:P-4)];
        %Mbm2(:,:)= [(u_wer(k_pocz-1:P-1).^2).*y_wer(k_pocz-1:P-1).^2 (u_wer(k_pocz-2:P-2).^2).*y_wer(k_pocz-2:P-2).^2 (u_wer(k_pocz-3:P-3).^2).*y_wer(k_pocz-3:P-3).^2 (u_wer(k_pocz-4:P-4).^2).*y_wer(k_pocz-4:P-4).^2];
        %Mbm3(:,:)= [u_wer(k_pocz-1:P-1).^3.*y_wer(k_pocz-1:P-1).^3 u_wer(k_pocz-2:P-2).^3.*y_wer(k_pocz-2:P-2).^3 u_wer(k_pocz-3:P-3).^3.*y_wer(k_pocz-3:P-3).^3 u_wer(k_pocz-4:P-4).^3.*y_wer(k_pocz-4:P-4).^3];
        %Mbm4(:,:)= [u_wer(k_pocz-1:P-1).^4.*y_wer(k_pocz-1:P-1).^4 u_wer(k_pocz-2:P-2).^4.*y_wer(k_pocz-2:P-2).^4 u_wer(k_pocz-3:P-3).^4.*y_wer(k_pocz-3:P-3).^2 u_wer(k_pocz-4:P-4).^4.*y_wer(k_pocz-4:P-4).^4];
        mb_wer = [mb_wer_u mb_wer_y Mbm1]; 
        ymod_ucz(k_pocz:P)=M*w;
        ymod_wer(k_pocz:P)=mb_wer*w;
                
        h = figure;
        set(h,'units','points','position',[10,10,1000,800]); 
        subplot(2,1,1)
        plot(kk,ymod_ucz,'g')
        ylim([-10 10])
        hold on
        plot(kk,y_ucz,'r--')
        ylim([-10 10])
        legend('y_{mod}','y_{dane}');
        title('y_{ucz}(k)');
        subplot(2,1,2);
        plot(kk,ymod_wer,'g')
        ylim([-10 10])
        hold on
        plot(kk,y_wer,'r--')
        ylim([-10 10])
        legend('y_{mod}','y_{dane}');
        title('y_{wer}(k)');
        name =  ['dane_dyn_mod_miesz1_brek_D_' num2str(D) 'N_' num2str(N) '.png'];
        saveas(h,name,'png');
        
        E_ucz = (ymod_ucz-y_ucz)'*(ymod_ucz-y_ucz);
        E_wer = (ymod_wer-y_wer)'*(ymod_wer-y_wer); 

        fprintf(fid,'dane_ucz_miesz1_brek_D=%d_N=%d, %d \n',D,N,E_ucz);
        fprintf(fid,'dane_wer_miesz1_brek_D=%d_N=%d, %d \n',D,N,E_wer);

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
            %Mum2(:,:)= [u_ucz(k-1)^2*past_ucz(1)^2 u_ucz(k-2)^2*past_ucz(2)^2 u_ucz(k-3)^2*past_ucz(3)^2 u_ucz(k-4)^2*past_ucz(4)^2];
            %Mum3(:,:)= [u_ucz(k-1)^3*past_ucz(1)^3 u_ucz(k-2)^3*past_ucz(2)^3 u_ucz(k-3)^3*past_ucz(3)^3 u_ucz(k-4)^3*past_ucz(4)^3];
            %Mum4(:,:)= [u_ucz(k-1)^4*past_ucz(1)^4 u_ucz(k-2)^4*past_ucz(2)^4 u_ucz(k-3)^4*past_ucz(3)^4 u_ucz(k-4)^4*past_ucz(4)^4];
            
            Mwm1(:,:)= [u_wer(k-1)*past_wer(1) u_wer(k-2)*past_wer(2) u_wer(k-3)*past_wer(3) u_wer(k-4)*past_wer(4)];
            %Mwm2(:,:)= [u_wer(k-1)^2*past_wer(1)^2 u_wer(k-2)^2*past_wer(2)^2 u_wer(k-3)^2*past_wer(3)^2 u_wer(k-4)^2*past_wer(4)^2];
            %Mwm3(:,:)= [u_wer(k-1)^3*past_wer(1)^3 u_wer(k-2)^3*past_wer(2)^3 u_wer(k-3)^3*past_wer(3)^3 u_wer(k-4)^3*past_wer(4)^3];
            %Mwm4(:,:)= [u_wer(k-1)^4*past_wer(1)^4 u_wer(k-2)^4*past_wer(2)^4 u_wer(k-3)^4*past_wer(3)^4 u_wer(k-4)^4*past_wer(4)^4];
            
            m_ucz = [m_ucz_u m_ucz_y Mum1];
            m_wer = [m_wer_u m_wer_y Mwm1]; 
            ymod_ucz(k)=m_ucz*w;
            ymod_wer(k)=m_wer*w;
            past_ucz = [ymod_ucz(k);past_ucz((1:numel(past_ucz)-1))];
            past_wer = [ymod_wer(k);past_wer((1:numel(past_wer)-1))];
        end
        
        h = figure;
        set(h,'units','points','position',[10,10,1000,800]);
        subplot(2,1,1)
        plot(kk,ymod_ucz,'g')
        hold on
        ylim([-10 10])
        plot(kk,y_ucz,'r--')
        ylim([-10 10])
        legend('y_{mod}','y_{dane}');
        title('y_{ucz}(k)');
        subplot(2,1,2);
        plot(kk,ymod_wer,'g')
        ylim([-10 10])
        hold on
        plot(kk,y_wer,'r--')
        ylim([-10 10])
        legend('y_{mod}','y_{dane}');
        title('y_{wer}(k)');
        name =  ['dane_dyn_mod_miesz1_rek_D_' num2str(D) 'N_' num2str(N) '.png'];
        saveas(h,name,'png');
        
        E_ucz = (ymod_ucz-y_ucz)'*(ymod_ucz-y_ucz);
        E_wer = (ymod_wer-y_wer)'*(ymod_wer-y_wer); 

        fprintf(fid,'dane_ucz_miesz1_rek_D=%d_N=%d, %d \n',D,N,E_ucz);
        fprintf(fid,'dane_wer_miesz1_rek_D=%d_N=%d, %d \n',D,N,E_wer);
    end
end


fclose(fid);