T = readtable("G:\Facultate\MATLAB\Proiect IS\HUPA-UCM Diabetes Dataset\Preprocessed\HUPA0001P.csv");
Ts = 300;
T.glucose = smoothdata(T.glucose, 'movmean', 5); 

data = iddata(T.glucose, [T.heart_rate T.basal_rate T.calories T.steps], Ts);
data = detrend(data);

[~,l1] = CorCalculator(T.heart_rate, T.glucose);
[~,l2] = CorCalculator(T.basal_rate, T.glucose);
[~,l3] = CorCalculator(T.calories, T.glucose);
[~,l4] = CorCalculator(T.steps, T.glucose);

% Creștem ordinele nb și nf semnificativ pentru u3 și u4 (pozițiile 3 și 4)
% pentru a forța modelul să capteze dinamica acestora care "scăpa" în reziduuri.
nk = [l1 l2 l3 l4]; 
nb = [4 4 4 4];   
nf = [4 4 4 4];   
nc = 6; 
nd = 6; 

idx = floor(0.7 * height(T));
data_id  = data(1:idx);
data_val = data(idx+1:end);

opt = bjOptions;
opt.Focus = 'prediction';
opt.Regularization.Lambda = 0.01; % Lambda foarte mic pentru a lăsa modelul să "urmărească" datele mai strâns
opt.SearchOptions.MaxIterations = 100;

model_bj = bj(data_id, [nb nc nd nf nk], opt);

figure; compare(data_val, model_bj, 12);
figure; resid(data_val, model_bj);