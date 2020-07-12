%% Transmitter of the OFDM system

function [data_transmit, NoCarriers] = Transmitter (data, NoPilots, trellis)

% Convolutionally encoding data 
codedata = convenc(data, trellis);

%% Interleaving coded data
QAMbit = 4; 
% 16-QAM: 2^4=16
matrix = reshape (codedata, size(codedata, 2)/QAMbit, QAMbit); % codedata is a column vector

intlvddata = matintrlv(matrix', 2, QAMbit/2)'; % Interleave the coded data

intlvddata = intlvddata';

% Binary to decimal conversion 
dec =  bi2de(intlvddata','left-msb');

%% 16-QAM Modulation/16-PSK Modulation 
y = qammod(dec,16);

% scatterplot(y)

% hModulator = comm.PSKModulator(16,'BitInput',true);
% 
% hModulator.PhaseOffset = pi/16; % Change the phase offset to pi/16
% 
% y=step(hModulator,dec);
% 
% constellation (y);

% Pilot insertion
pilt_data = PilotInsertion(y,NoPilots);

% IFFT
NoCarriers = length (pilt_data);
ifft_sig = ifft(pilt_data', NoCarriers);

% Adding Cyclic Extension
data_transmit = CyclicPrefixAdd(ifft_sig);