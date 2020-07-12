%% OFDM TRANSCEIVER FRAMEWORK
% NoPilots=4;
% NoCarriers=64; % returned from the Transmitter function

% coding used: Convolutional coding
% Single frame size: 96 bits
% Total no. of Frames: 100
% Modulation : 16-QAM;


BitInFrame = 1;
t_data = randint(9600,1)';
BERrow = 1;
NoPilots = 4;

%%                           TRANSMITTER

for d = 1:100; 
    data = t_data(BitInFrame:BitInFrame+95);

    BitInFrame = BitInFrame+96; 
    trellis = poly2trellis(7,[171 133]);

    % used for convolutional encoded/decade 
    % 7 is the constrain length of the convolutional code;
    % [171 133] is the polynomial the input/output relation in OCT

    [data_transmit, NoCarriers] = Transmitter (data, NoPilots, trellis);

    % Channel

    % SNR
    o=1;
    for snr = 0:2:50 
        ofdm_sig = awgn(data_transmit,snr,'measured');

        % Adding white Gaussian Noise

%         figure;
% 
%         index = 1:80;
% 
%         plot(index,data_transmit,'b', index, ofdm_sig, 'r') %  plot both signals 
%         legend ('Original Signal to be Transmitted', 'Signal with AWGN');



%%                           RECEIVER

        rxed_data =  Receiver(ofdm_sig, NoCarriers, trellis);

        % Calculating BER 
        rxed_data = rxed_data(:)';

        c = xor (data, rxed_data);

        errors = nnz (c);

%         figure;
%         subplot (311);
%         plot(1:96,data);
%         title('Original Signal');
% 
%         subplot (312);
%         plot(1:96,rxed_data);
%         title('Received Signal');
% 
%         subplot (313);
%         plot(1:96,data,'--',1:96,rxed_data,':');
%         legend ('Original', 'Received', 'Comparison');

        BER(BERrow,o) = errors/length(data);
        o=o+1;
    end 
    % SNR loop ends here
    BERrow = BERrow+1;

end
% main data loop

% Time averaging for optimum results
for col = 1:25;

    % change if SNR Loop Changed

    ber(1,col) = 0;
    for row = 1:100;

        ber(1,col) = ber (1, col) + BER (row, col);

    end

end

ber = ber./100;

figure;
i = 0:2:48;

semilogy(i,ber);

title('BER vs SNR');
ylabel ('BER');
xlabel('SNR (dB)');
grid on