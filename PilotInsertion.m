%% Pilot Insertion

function pilt_data = PilotInsertion(y,NoPilots)

lendata=length(y);
pilt=3+3j;
nofpits=NoPilots;

k=1;

for i=(1:13:52)
    
    pilt_data1(i)=pilt;

    for j=(i+1:i+12);
        pilt_data1(j)=y(k);
        k=k+1;
    end
end

pilt_data1=pilt_data1';   % size of pilt_data =52
pilt_data(1:52)=pilt_data1(1:52);    % upsizing to 64
pilt_data(13:64)=pilt_data1(1:52);   % upsizing to 64

for i=1:52
    
    pilt_data(i+6)=pilt_data1(i);
    
end
