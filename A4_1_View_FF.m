%% A4_1_View_FF
% view a movie of the full-field turbulent wind file & plots

ADFileName = fullfile(save_dir,[save_name,'.',outputExtension]);
[velocity, twrVelocity, y, z, zTwr, nz, ny, dz, dy, dt, zHub, z1,mffws]...
    = readTSgrid(ADFileName);


%% Movie

sampleRate  = 1;         %sec
sampleInt   = round(sampleRate/dt);


if 0   
    figure(11);
    for i = 1:sampleInt:size(velocity(:,1,1,1),1)
        
        subplot(131);
        u_ = velocity(i,1,:,:);
        u = reshape(u_,[length(y),length(z)]);
        imagesc(y,z,u');
        set(gca,'YDir','normal')
        colorbar;
        title('u [m/s]')
        
        subplot(132);
        v_ = velocity(i,2,:,:);
        v = reshape(v_,[length(y),length(z)]);
        imagesc(y,z,v');
        set(gca,'YDir','normal')
        colorbar;
        title(['v [m/s], t = ',num2str((i-1)*dt),'s']);
        
        subplot(133);
        w_ = velocity(i,3,:,:);
        w = reshape(w_,[length(y),length(z)]);
        imagesc(y,z,w');
        set(gca,'YDir','normal')
        colorbar;
        title('w [m/s]');
        
        pause(sampleRate);  
        
    end
    
end



%% Averages

figure(12);

%Streamwise
u_ = velocity(:,1,:,:);
u_bar = reshape(mean(u_,1),[length(y),length(z)]);

subplot(131);
imagesc(y,z,u_bar');
set(gca,'YDir','normal')
colorbar;
title('mean u [m/s]');

%Horizontal
v_ = velocity(:,2,:,:);
v_bar = reshape(mean(v_,1),[length(y),length(z)]);

subplot(132);
imagesc(y,z,v_bar');
set(gca,'YDir','normal')
colorbar;
title('mean v [m/s]');

%Vertical
w_ = velocity(:,3,:,:);
w_bar = reshape(mean(w_,1),[length(y),length(z)]);

subplot(133);
imagesc(y,z,w_bar');
set(gca,'YDir','normal')
colorbar;
title('mean w [m/s]');

%% T.I. & Std

figure(13);

%Streamwise
u_hat = reshape(std(u_,1),[length(y),length(z)]);

subplot(131);
imagesc(y,z,u_hat');
set(gca,'YDir','normal')
colorbar;
title('std u [m/s]');

%Horizontal
v_hat = reshape(std(v_,1),[length(y),length(z)]);

subplot(132);
imagesc(y,z,v_hat');
set(gca,'YDir','normal')
colorbar;
title('std v [m/s]');

%Vertical
w_hat = reshape(std(w_,1),[length(y),length(z)]);

subplot(133);
imagesc(y,z,w_hat');
set(gca,'YDir','normal')
colorbar;
title('std w [m/s]');


%% Hub Height
time = 0:dt:size(u_,1)*dt-dt;
u_h = squeeze(u_(:,:,:,floor(size(u_,4)/2)));
v_h = squeeze(v_(:,:,:,floor(size(u_,4)/2)));
w_h = squeeze(w_(:,:,:,floor(size(u_,4)/2)));


figure(14)
subplot(131)
imagesc(y,time,u_h);
set(gca,'YDir','normal');
title('u (m/s)');
ylabel('time (s)');
colorbar;

subplot(132)
imagesc(y,time,v_h);
set(gca,'YDir','normal');
xlabel('lateral distance (m)');
title('v (m/s)');
colorbar;

subplot(133)
imagesc(y,time,w_h);
set(gca,'YDir','normal');
title('w (m/s)')
colorbar;

%% Print?

printDir = 'C:\Users\danza\OneDrive\Documents\CU Energy\Energy Talks';

if 0
    Af_SaveFigure(12,'means',printDir);
    Af_SaveFigure(14,'hubheigh',printDir);
end

