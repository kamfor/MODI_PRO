K = 5.5; 
T1 = 7; 
T2 = 7; 
a1 = -0.19; 
a2 = -0.05; 
a3 = -0.95; 
a4 = -0.45;

Tp = 0.1;
simOutC = sim('dynamiczny_model_ciagly'); 
simOutD = sim('dynamiczny_model_dyskretny'); 

h = figure;
x0=10;
y0=10;
width=1000;
height=800;
set(h,'units','points','position',[x0,y0,width,height]); 
plot(y_c.time,y_c.signals.values,'b','LineWidth', 2);
hold on; 
stairs(y_d.time,y_d.signals.values,'r','LineWidth', 2);
legend({'Model dynamiczny ciągły', 'Model dynamiczny dyskretny'}, ...
    'Location', 'NorthEast');
title('Tp = 0.1');
saveas(h,'tp_01','svg');


Tp = 0.25;
simOutC = sim('dynamiczny_model_ciagly'); 
simOutD = sim('dynamiczny_model_dyskretny'); 

h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
plot(y_c.time,y_c.signals.values,'b','LineWidth', 2);
hold on; 
stairs(y_d.time,y_d.signals.values,'r','LineWidth', 2);
legend({'Model dynamiczny ciągły', 'Model dynamiczny dyskretny'}, ...
    'Location', 'NorthEast');
title('Tp = 0.25');
saveas(h,'tp_025','svg'); 


Tp = 0.5;
simOutC = sim('dynamiczny_model_ciagly'); 
simOutD = sim('dynamiczny_model_dyskretny'); 

h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
plot(y_c.time,y_c.signals.values,'b','LineWidth', 2);
hold on; 
stairs(y_d.time,y_d.signals.values,'r','LineWidth', 2);
legend({'Model dynamiczny ciągły', 'Model dynamiczny dyskretny'}, ...
    'Location', 'NorthEast');
title('Tp = 0.5');
saveas(h,'tp_05','svg');

Tp = 1;
simOutC = sim('dynamiczny_model_ciagly'); 
simOutD = sim('dynamiczny_model_dyskretny'); 

h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
plot(y_c.time,y_c.signals.values,'b','LineWidth', 2);
hold on; 
stairs(y_d.time,y_d.signals.values,'r','LineWidth', 2);
legend({'Model dynamiczny ciągły', 'Model dynamiczny dyskretny'}, ...
    'Location', 'NorthEast');
title('Tp = 1');
saveas(h,'tp_1','svg');

Tp = 2;
simOutC = sim('dynamiczny_model_ciagly'); 
simOutD = sim('dynamiczny_model_dyskretny'); 

h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
plot(y_c.time,y_c.signals.values,'b','LineWidth', 2);
hold on;
stairs(y_d.time,y_d.signals.values,'r','LineWidth', 2);
legend({'Model dynamiczny ciągły', 'Model dynamiczny dyskretny'}, ...
    'Location', 'NorthEast');
title('Tp = 2');
saveas(h,'tp_2','svg');

%charajterystyka ststyczna 
u  = -1: .1 : 1;
y1 = K*(a1*u+a2*u.^2+a3*u.^3+a4*u.^4); 
h = figure;
set(h,'units','points','position',[x0,y0,width,height]); 
plot(u, y1, 'b','LineWidth', 2)
grid on
title('Charakterystyka statyczna modelu');
xlabel('u')
ylabel('y')
saveas(h,'statyczna','svg');

%charajterystyka ststyczna zlinearyzowana 4 punkty
us = [-0.25; 0.25; 0.6; 0.8]; 
for k = 1:4
    y2 = K*(a1*u+a2*(2*us(k)*u-us(k)^2)+a3*(3*us(k)^2*u-2*us(k)^3)+a4*(4*us(k)^3*u-3*us(k)^4));
    h = figure;
    set(h,'units','points','position',[x0,y0,width,height]); 
    plot(u, y1, 'b','LineWidth', 2)
    hold on; 
    plot(u, y2, 'r','LineWidth', 2)
    grid on
    legend({'Charakterystyka statyczna', 'Charakterystyka ststyczna zlinearyzowana'}, ...
    'Location', 'NorthEast');
    title('Charakterystyka statyczna modelu');
    xlabel('u')
    name =  ['punkt_linearyzacji:' num2str(us(k))];
    title(name);
    saveas(h,name,'svg');   
    
end





