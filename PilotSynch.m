%% Pilot Synch

% Pilots are used to track the residual phase error if present after frequency correction.
% Without this correction the constellation points starts rotating either +ve/-ve angle.
% It is very much sensitive at higher constellation.


function synched_sig = PilotSynch(ff_sig)
for i=1:52
    
    synched_sig1(i)=ff_sig(i+6);
    
end

k=1;

for i=(1:13:52)
        
    for j=(i+1:i+12);
        synched_sig(k)=synched_sig1(j);
        k=k+1;
    end
end

% scatterplot(synched_sig)
