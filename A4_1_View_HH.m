%% A4_1_View_HH


%% Extract Data from HH file
fid = fopen(fullfile(save_dir,save_name));

hh_line = 0;
i = 1;
while hh_line ~= -1
    hh_line = fgets(fid);
    if hh_line(1) ~= '!' & hh_line ~= -1
        W(i,:) = str2num(hh_line);
        i=i+1;
    end
end

fclose(fid);
%% Compute u, v, w components @ hub height

time     = W(:,1);
horSpeed = W(:,2);
windDir  = W(:,3);
verSpeed = W(:,4);

u = horSpeed.*cosd(windDir);
v = horSpeed.*sind(windDir);
w = verSpeed;


%% Plot (Figure 60)

figure(60);
subplot(311);
plot(time,u);
axis tight;
ylabel('u [m/s]')

subplot(312);
plot(time,v);
axis tight;
ylabel('v [m/s]')

subplot(313);
plot(time,w);
axis tight;
ylabel('w [m/s]')


%% Print Data

%Expected Turbulence Intensity (from IEC standards)

if Disturbance.Class == 'A'
    Iref    = .16;
elseif Disturbance.Class == 'B'
    Iref    = .14;
elseif Disturbance.Class == 'C'
    Iref    = .12;
else    %Default is Class A
    Iref    = .16;
end
b       = 5.6;
sig1    = Iref*(0.75*Disturbance.U_ref + b);
ETI     = sig1/Disturbance.U_ref;

disp(['Expected T.I. : ',num2str(ETI)]);

%Sampled Turbulence Intensity (from u data)
sig1_s  = std(u);
STI     = sig1_s/mean(u);

disp(['Sampled T.I. : ',num2str(STI)]);



