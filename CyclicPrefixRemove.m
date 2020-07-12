%% Cyclic prefix Remove
% This function is called for removing the 'Cyclic Prefix'


function rxed_sig = CyclicPrefixRemove(data)

for i=1:64
    
    rxed_sig(i)=data(i+16); % 'rxed_sig' is the received signal that will 
                            % be returned    
end
