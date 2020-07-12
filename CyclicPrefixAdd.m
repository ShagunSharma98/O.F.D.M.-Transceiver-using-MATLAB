%% Cyclic Prefix Add
% This function is called for adding the 'Cyclic Prefix'


function data_transmit = CyclicPrefixAdd(ifft_sig)
data_transmit=zeros(80,1);
data_transmit(1:16)=ifft_sig(49:64);
for i=1:64                           % 'data_transmit' is the data to be 
                                     % transmitted that will be returned 
    data_transmit(i+16)=ifft_sig(i); % from this function
    
                                     
end