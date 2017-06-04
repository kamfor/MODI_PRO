function dane_dynamiczne()
    ucz = dlmread('danedynucz9.txt');
    wer = dlmread('danedynwer9.txt');
   

    ucz_u = ucz(:, 1);
    ucz_y = ucz(:, 2);
    wer_u = wer(:, 1);
    wer_y = wer(:, 2);

    for i = 1:1
        [W, e, e_v] = model_bez_rekurencji(ucz_u, ucz_y, wer_u, wer_y, 4,2);
        [W, e, e_v] = model_z_rekurencja(W, ucz_u, ucz_y, wer_u, wer_y, 4,2);  
    end
end

function result = error(y, v)
    result = (v-y)'*(v-y);
end

function [W, err, err_v] = model_bez_rekurencji(u, y, u_v, y_v, D, N)
    Mu = zeros(0, numel(u)-D);
    My = zeros(0, numel(y)-D);
    Mu_v = zeros(0, numel(u_v)-D);
    My_v = zeros(0, numel(y_v)-D);
    
    for i = 1:D
        for j = 1:N
            Mu = [Mu, u(D-i+1:numel(u)-i).^j];
            My = [My, y(D-i+1:numel(y)-i).^j];
            Mu_v = [Mu_v, u_v(D-i+1:numel(u_v)-i).^j];
            My_v = [My_v, y_v(D-i+1:numel(y_v)-i).^j];
        end
    end
    
    M = [Mu, My];
    M_v = [Mu_v, My_v];
    Y = y(D+1:numel(y));
    Y_v = y_v(D+1:numel(y_v));
    
    W = M\Y;
    Y_mod = M*W;
    Y_v_mod = M_v*W;
    err = error(Y, Y_mod);
    err_v = error(Y_v, Y_v_mod);
    
    h = figure;
    set(h,'units','points','position',[10,10,1000,800]); 
    subplot(2,1,1)
    plot(y)
    ylim([-10 10])
    hold on
    plot(Y_mod,'g')
    ylim([-10 10])
    title('y_{ucz}(k)');
    subplot(2,1,2);
    plot(y_v)
    ylim([-10 10])
    hold on
    plot(Y_v_mod,'g')
    ylim([-10 10])
    title('y_{wer}(k)');
    saveas(h,'sdasasddsd','png');
end

function [W, err, err_v] = model_z_rekurencja(W, u, y, u_v, y_v, D, N)
    k = numel(u);
    y_mod_train = zeros(k-D,1);
    y_mod_valid = zeros(k-D,1);
    y_mod_train(1:D) = y(1:D);
    y_mod_valid(1:D) = y_v(1:D);

    for j=D+1:k
        y_mod_valid(j) = 0;
        y_mod_train(j) = 0;
        for i=1:D
            for p=1:N
                y_mod_valid(j) = y_mod_valid(j)+(u_v(j-i).^p)*W(i+(p-1))+(y_mod_valid(j-i).^p)*W(D+i+(p-1));
                y_mod_train(j) = y_mod_train(j)+(u(j-i).^p)*W(i+(p-1))+(y_mod_train(j-i).^p)*W(D+i+(p-1));
            end
        end
    end

    y_mod_valid = y_mod_valid(D+1:k);
    y_mod_train = y_mod_train(D+1:k);

    err_v = error(y_mod_valid, y_v(D+1:k));
    err = error(y_mod_train, y(D+1:k));
    
    
        h = figure;
        set(h,'units','points','position',[10,10,1000,800]); 
        subplot(2,1,1)
        plot(y)
        ylim([-10 10])
        hold on
        plot(y_mod_train,'g')
        ylim([-10 10])
        title('y_{ucz}(k)');
        subplot(2,1,2);
        plot(y_v)
        ylim([-10 10])
        hold on
        plot(y_mod_valid,'g')
        ylim([-10 10])
        title('y_{wer}(k)');
        saveas(h,'sdsdsd','png');
end