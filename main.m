T = readtable("G:\Facultate\MATLAB\Proiect IS\HUPA-UCM Diabetes Dataset\Preprocessed\HUPA0001P.csv");

Ts = 300;
data = iddata(T.glucose, [T.calories T.basal_rate T.steps], Ts);
data = detrend(data,0);


[~,lagCalories] = CorCalculator(T.calories,T.glucose);
[~,lagBasal_rate] = CorCalculator(T.basal_rate,T.glucose);
[~,lagSteps] = CorCalculator(T.steps,T.glucose);


nk = [lagCalories lagBasal_rate lagSteps]; 

nb = [3 3 3];   
nf = [4 4 4];   
nc = 3; nd = 3;

N = height(T);
idx = floor(0.6 * N);
data_id  = data(1:idx);
data_val = data(idx+1:end);

model_bj = bj(data_id, [nb nf nc nd nk]);
figure;
compare(model_bj,data_val)
