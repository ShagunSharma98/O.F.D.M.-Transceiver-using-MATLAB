%% Receiver of the OFDM system


function data_receive = Receiver(data, NoCarriers, trellis)

% Removing Cyclic Extension
rxed_sig = CyclicPrefixRemove(data);

% FFT
ff_sig = fft(rxed_sig, NoCarriers);

% Pilot Synch
synched_sig = PilotSynch(ff_sig);

% scatterplot(synched_sig);

% Demodulation 16-QAM/16-PSK 
demo_data = qamdemod(synched_sig,16);

% hDemod = comm.PSKDemodulator(16, 'PhaseOffset', pi/16);

% demo_data = step(hDemod, synched_sig');

% Decimal to binary conversion 
bin = de2bi(demo_data','left-msb');

bin = bin';

% De-Interleaving 
QAMbit = 4; % 16- OAM; 2^4=16 
deintlvddata = matdeintrlv(bin, 2,QAMbit/2); % De-Interleave
deintlvddata = deintlvddata';
deintlvddata = deintlvddata(:)';

% Decoding data 
data_receive = vitdec(deintlvddata, trellis,5,'trunc','hard'); % veterbi decoder