%Clear
clear
clc
close all

%% Define G1, G2, G3, G4, H1, H2 and H3

G1_num = 1;
G1_den = [1 0 0];

G2_num = 1;
G2_den = [1 1];

G3_num = 1;
G3_den = [1 0];

G4_num = 1;
G4_den = [2 0];

H1_num = 1;
H1_den = [1 0];

H2_num = 1;
H2_den = [1 -1];

H3_num =1;
H3_den = [1 -2];

%%Reduce Block Diagram

% For G4H3 = EQ1
EQ1_num = conv(G4_num,H3_num);
EQ1_den = conv(G4_den,H3_den);
EQ1 = tf(EQ1_num, EQ1_den)


% For G3(G4H3) = EQ2
EQ2_num = conv(G3_num,EQ1_num);
EQ2_den = conv(G3_den,EQ1_den);
EQ2 = tf(EQ2_num, EQ2_den)


% For parallel G3 & G4H3 = EQ3
EQ3_num = conv(G3_num, EQ2_den);
EQ3_den_cons = [2 -4 0 1 0];
EQ3_den = conv(EQ3_den_cons, G3_num);
EQ3 = tf(EQ3_num, EQ3_den)


% For G2(G3/1+G3(H3G4) = EQ4
EQ4_num = conv(G2_num,EQ3_num);
EQ4_den = conv(G2_den,EQ3_den);
EQ4 = tf(EQ4_num, EQ4_den)


% For G2G3 = EQ5
EQ5_num = conv(G2_num,G3_num);
EQ5_den = conv(G2_den,G3_den);
EQ5 = tf(EQ5_num, EQ5_den)


% For G2G3H2 = EQ6
EQ6_num = conv(EQ5_num,H2_num);
EQ6_den = conv(EQ5_den,H2_den);
EQ6 = tf(EQ6_num, EQ6_den)

% For parallel H2 & G2H3G3G4 = EQ7
EQ7_num_cons = [2 -4 -2 4 0 1];
EQ7_num = conv(EQ5_num, EQ7_num_cons);
EQ7_den_cons = [4 -12 -4 28 16 0 0 0 0 0];
EQ7_den = conv(EQ7_den_cons, EQ5_num);
EQ7 = tf(EQ7_num, EQ7_den)

% For G1((G2H3G3G4/1+H2(G2H3G3H4)) = EQ8
EQ8_num = conv(G1_num, EQ7_num);
EQ8_den = conv(G1_den, EQ7_den);
EQ8 = tf(EQ8_num, EQ8_den)

% For G4G1((G2H3G3G4/1+H2(G2H3G3H4)) = EQ9
EQ9_num = conv(G4_num, EQ8_num);
EQ9_den = conv(G4_den, EQ8_den);
EQ9 = tf(EQ9_num, EQ9_den)

% For (G1G2G3G4/1+G3G4H3+G2G3H2+G1G2G3H1) =EQ10
EQ10_num_cons = [4 -4 -12 4 8 0 0 0 0 0 0 0 0];
EQ10_num = conv(EQ9_num, EQ10_num_cons);
EQ10_den_cons = [8 0 -32 -4 32 -8 -20 -8 -12 4 8 0 0 0 0 0 0 0];
EQ10_den = conv(EQ10_den_cons, EQ9_num);
TF = tf(EQ10_num, EQ10_den)

% Step Response
%step(TF,0:0.1:20)