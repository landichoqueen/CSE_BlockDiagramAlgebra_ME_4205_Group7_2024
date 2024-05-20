% Clear
clear
clc
close all

%% Define G1, G2, G3, H1, H2, AND H3
G1_num = [1];
G1_den = [1 0 0];

G2_num = [1];
G2_den = [1 1];

G3_num = [1];
G3_den = [1 0];

H1_num = [1];
H1_den = [1 0];

H2_num = [1];
H2_den = [1 -1];

H3_num = [1];
H3_den = [1 -2];

%% Reduce Block Diagrams

G3H3_num = conv(G3_num,H3_num)
G3H3_den = conv(G3_den,H3_den)

G3H3_den_sum = [1 -2 1]

TF1_num = conv(G3_num,G3H3_den)
TF1_den = conv(G3_den,G3H3_den_sum)

G2_sum = [1 2]

TF2_num = conv(G2_sum,G2_den)
TF2_den = conv(G2_den,G2_num)

G2H2_num = conv(G2_num,H2_num)
G2H2_den = conv(G2_den,H2_den)

G2H2_den_sum = [1 0 0]

TF3_num = conv(G2_num,G2H2_den)
TF3_den = conv(G2_den,G2H2_den_sum)

TF4_num = conv(TF1_num,TF2_num)
TF4_den = conv(TF1_den,TF2_den)

TF5_num = conv(G1_num,TF3_num)
TF5_den = conv(G1_den,TF3_den)

G1G2H2_num = conv(G1_num,TF3_num)
G1G2H2_den = conv(G1_den,TF3_den)

G1G2H1H2_sum = [1 1 0 0 1 0 -1]
G1G2H1H2_den = conv(G1G2H2_den,H1_den)

TF6_num = conv(TF5_num,G1G2H1H2_den)
TF6_den = conv(TF5_den,G1G2H1H2_sum)

TF_num = conv(TF4_num,TF6_num)
TF_den = conv(TF4_den,TF6_den)