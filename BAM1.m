clc;
clear;

X(1, :) = [1 1 1 -1 1 -1 -1 1 -1]; % Patron 1 de entrada
X(2, :) = [1 -1 -1 1 -1 -1 1 1 1]; % Patron 2 de entrada
Y(1, :) = [1 -1 -1]; % Patron de salida al que se asocia el patron 1
Y(2, :) = [-1 -1 1]; % Patron de salida al que se asocia el patron 2
W = X' * Y; % Calculo del vector de pesos

KX = size(X, 2); % Tamaño de los vectores de entrada
KY = size(Y, 2); % Tamaño de los vectores de salida

epochs = 21; % Numero de iteraciones

SX = zeros(KX, epochs); % Historico de salidas para los patrones de entrada
SY = zeros(KY, epochs); % Historico de salidas para los patrones de salida

SX(:, 1) = X(1, :); % Se establece la primera salida de los patrones de 
% entrada al patron 1 (el que queremos memorizar en este caso)
SY(:, 1) = sign(SX(:, 1)' * W); % Se establece la primera salida de los
% patrones de salida al resultado de la funcion signo de multiplicar el 
% primer patron de entrada al vector de pesos calculado

for i = 2:epochs
    SX(:, i) = sign(W * SY(:, i - 1)); % Se calcula la salida de los
    % patrones de entrada en funcion del vector de pesos y la salida de
    % los patrones de salida
    SY(:, i) = sign(SX(:, i)' * W); % Con la salida de los patrones de 
    % entrada calculada, se calcula la de los patrones de salida (junto
    % con el vector de pesos)
    if (sum(SX(:, epochs) == SX(:, epochs - 1)) == KX && ...
        sum(SY(:, epochs) == SY(:, epochs - 1)) == KY) % Si se estabiliza
        % la red (es decir, los estados de entrada y salida actuales son
        % iguales a los anteriores), se para la ejecucion
        break;
    end
end