clear all;
%% inicjalizacja
x0=10;
y0=10;
width=1000;
height=800;
%% import danych
Data = importdata('danestat9.txt');
u = Data(:,1);
y = Data(:,2);
lenght=size(Data);
P = lenght(1); %liczba probek
k_pocz = 1; % probka poczatkowa
%% wykres danych statycznych
h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
scatter(u,y)
name =  'dane modelu statycznego';
title(name);
name =  'dane_stat.png';
saveas(h,name,'png');
%% podzial na zbior uczacy i weryfikujacy
y_ucz=zeros(P/2,1);u_ucz=zeros(P/2,1);y_wer=zeros(P/2,1);u_wer=zeros(P/2,1);
m=1;n=1;
for k=1:P
   if mod(k,2)==0
       y_ucz(m) = y(k);
       u_ucz(m) = u(k);
       m=m+1;
   else
       y_wer(n) = y(k);
       u_wer(n) = u(k);
       n=n+1;
   end
end
h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
scatter(u_ucz,y_ucz)
name =  'zbiór uczący';
title(name);
name =  'dane_stat_ucz.png';
saveas(h,name,'png');
h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
scatter(u_wer,y_wer)
name =  'zbiór weryfikujący';
title(name);
name =  'dane_stat_wer.png';
saveas(h,name,'png');
%% statyczny model 
Y = y_ucz(k_pocz:P/2);
o = ones(P,1);
ymod(1:k_pocz) = y(1:k_pocz);
fid = fopen('bledy_stat','w+'); 

%% N=1
M = [o(k_pocz:P/2) u_ucz(k_pocz:P/2)];
w = M\Y;
ymod_ucz=w(1)+w(2)*u_ucz;
ymod_wer=w(1)+w(2)*u_wer;
    
h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
scatter(u_ucz,ymod_ucz,'filled')
hold on
scatter(u_ucz,y_ucz)
name =  'Statyczny model stopnia 1 - dane uczące';
title(name);
name =  'dane_stat_1_ucz.png';
saveas(h,name,'png');

h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
scatter(u_wer,ymod_wer,'filled')
hold on
scatter(u_wer,y_wer)
name =  'Statyczny model stopnia 1 - dane weryfikujące';
title(name);
name =  'dane_stat_1_wer.png';
saveas(h,name,'png');

E_ucz = 0;
E_wer = 0;
for k=k_pocz:P/2
   E_ucz = E_ucz + (ymod_ucz(k)-y_ucz(k))^2; 
   E_wer = E_wer + (ymod_wer(k)-y_wer(k))^2; 
end

fprintf(fid,'dane_ucz_1 %d \n',E_ucz);
fprintf(fid,'dane_wer_1 %d \n',E_wer); 

%% N=2
M = [o(k_pocz:P/2) u_ucz(k_pocz:P/2) u_ucz(k_pocz:P/2).^2];
w = M\Y;
ymod_ucz=w(1)+w(2)*u_ucz+w(3)*u_ucz.^2; 
ymod_wer=w(1)+w(2)*u_wer+w(3)*u_wer.^2;
    
h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
scatter(u_ucz,ymod_ucz,'filled')
hold on
scatter(u_ucz,y_ucz)
name =  'Statyczny model stopnia 2 - dane uczące';
title(name);
name =  'dane_stat_2_ucz.png';
saveas(h,name,'png');

h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
scatter(u_wer,ymod_wer,'filled')
hold on
scatter(u_wer,y_wer)
name =  'Statyczny model stopnia 2 - dane weryfikujące';
title(name);
name =  'dane_stat_2_wer.png';
saveas(h,name,'png');

E_ucz = 0;
E_wer = 0;
for k=k_pocz:P/2
   E_ucz = E_ucz + (ymod_ucz(k)-y_ucz(k))^2; 
   E_wer = E_wer + (ymod_wer(k)-y_wer(k))^2; 
end

fprintf(fid,'dane_ucz_2 %d \n',E_ucz);
fprintf(fid,'dane_wer_2 %d \n',E_wer; 

%% N=3
M = [o(k_pocz:P/2) u_ucz(k_pocz:P/2) u_ucz(k_pocz:P/2).^2 u_ucz(k_pocz:P/2).^3];
w = M\Y;
ymod_ucz=w(1)+w(2)*u_ucz+w(3)*u_ucz.^2+w(4)*u_ucz.^3;  
ymod_wer=w(1)+w(2)*u_wer+w(3)*u_wer.^2+w(4)*u_wer.^3;

h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
scatter(u_ucz,ymod_ucz,'filled')
hold on
scatter(u_ucz,y_ucz)
name =  'Statyczny model stopnia 3 - dane uczące';
title(name);
name =  'dane_stat_3_ucz.png';
saveas(h,name,'png');

h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
scatter(u_wer,ymod_wer,'filled')
hold on
scatter(u_wer,y_wer)
name =  'Statyczny model stopnia 3 - dane weryfikujące';
title(name);
name =  'dane_stat_3_wer.png';
saveas(h,name,'png');

E_ucz = 0;
E_wer = 0;
for k=k_pocz:P/2
   E_ucz = E_ucz + (ymod_ucz(k)-y_ucz(k))^2; 
   E_wer = E_wer + (ymod_wer(k)-y_wer(k))^2; 
end

fprintf(fid,'dane_ucz_3 %d \n',E_ucz);
fprintf(fid,'dane_wer_3 %d \n',E_wer); 

%% N=4
M = [o(k_pocz:P/2) u_ucz(k_pocz:P/2) u_ucz(k_pocz:P/2).^2 u_ucz(k_pocz:P/2).^3 u_ucz(k_pocz:P/2).^4];
w = M\Y;
ymod_ucz=w(1)+w(2)*u_ucz+w(3)*u_ucz.^2+w(4)*u_ucz.^3+w(5)*u_ucz.^4;  
ymod_wer=w(1)+w(2)*u_wer+w(3)*u_wer.^2+w(4)*u_wer.^3+w(5)*u_wer.^4; 
    
h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
scatter(u_ucz,ymod_ucz,'filled')
hold on
scatter(u_ucz,y_ucz)
name =  'Statyczny model stopnia 4 - dane uczące';
title(name);
name =  'dane_stat_4_ucz.png';
saveas(h,name,'png');

h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
scatter(u_wer,ymod_wer,'filled')
hold on
scatter(u_wer,y_wer)
name =  'Statyczny model stopnia 4 - dane weryfikujące';
title(name);
name =  'dane_stat_4_wer.png';
saveas(h,name,'png');

E_ucz = 0;
E_wer = 0;
for k=k_pocz:P/2
   E_ucz = E_ucz + (ymod_ucz(k)-y_ucz(k))^2; 
   E_wer = E_wer + (ymod_wer(k)-y_wer(k))^2; 
end

fprintf(fid,'dane_ucz_4 %d \n',E_ucz);
fprintf(fid,'dane_wer_4 %d \n',E_wer; 

%% N=5
M = [o(k_pocz:P/2) u_ucz(k_pocz:P/2) u_ucz(k_pocz:P/2).^2 u_ucz(k_pocz:P/2).^3 u_ucz(k_pocz:P/2).^4 u_ucz(k_pocz:P/2).^5];
w = M\Y;
ymod_ucz=w(1)+w(2)*u_ucz+w(3)*u_ucz.^2+w(4)*u_ucz.^3+w(5)*u_ucz.^4+w(6)*u_ucz.^5; 
ymod_wer=w(1)+w(2)*u_wer+w(3)*u_wer.^2+w(4)*u_wer.^3+w(5)*u_wer.^4+w(6)*u_wer.^5;

h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
scatter(u_ucz,ymod_ucz,'filled')
hold on
scatter(u_ucz,y_ucz)
name =  'Statyczny model stopnia 5 - dane uczące';
title(name);
name =  'dane_stat_5_ucz.png';
saveas(h,name,'png');

h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
scatter(u_wer,ymod_wer,'filled')
hold on
scatter(u_wer,y_wer)
name =  'Statyczny model stopnia 5 - dane weryfikujące';
title(name);
name =  'dane_stat_5_wer.png';
saveas(h,name,'png');

E_ucz = 0;
E_wer = 0;
for k=k_pocz:P/2
   E_ucz = E_ucz + (ymod_ucz(k)-y_ucz(k))^2; 
   E_wer = E_wer + (ymod_wer(k)-y_wer(k))^2; 
end

fprintf(fid,'dane_ucz_5 %d \n',E_ucz);
fprintf(fid,'dane_wer_5 %d \n',E_wer); 

fclose(fid); 
