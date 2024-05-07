
clc
clearvars

% Creazione del modello Simulink
model = 'simulink_model_prova';
open_system(new_system(model));

% Aggiunta del blocco Step e del segnale di input
add_block('simulink/Sources/Step', [model '/Step']);

% Aggiunta dei blocchi Transfer Function
add_block('simulink/Continuous/Transfer Fcn', [model '/Transfer Function 1']);
add_block('simulink/Continuous/Transfer Fcn', [model '/Transfer Function 2']);
set_param([model '/Transfer Function 1'], 'Numerator', '1', 'Denominator', '[1 1 1]');
set_param([model '/Transfer Function 2'], 'Numerator', '1', 'Denominator', '[1 1 1]');
add_line(model, 'Step/1', 'Transfer Function 1/1');
add_line(model, 'Step/1', 'Transfer Function 2/1');

% Aggiunta della funzione di discretizzazione
add_block('simulink/Discrete/Discrete Transfer Fcn', [model '/Discretization 1']);
add_block('simulink/Discrete/Discrete Transfer Fcn', [model '/Discretization 2']);
add_line(model, 'Transfer Function 1/1', 'Discretization 1/1');
add_line(model, 'Transfer Function 2/1', 'Discretization 2/1');
