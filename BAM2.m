clc;
clear;

load('barco.mat')
load('textoBarco.mat')
load('coche.mat')
load('textoCoche.mat')

[KX1, KX2] = size(barco);
[KY1, KY2] = size(textoBarco);

X(1, :) = reshape(barco, 1, KX1 * KX2);
X(2, :) = reshape(coche, 1, KX1 * KX2);
Y(1, :) = reshape(textoBarco, 1, KY1 * KY2);
Y(2, :) = reshape(textoCoche, 1, KY1 * KY2);

W = X' * Y;
epochs = 21;

SX = zeros(KX1 * KX2, epochs);
SY = zeros(KY1 * KY2, epochs);

noiseInput = imnoise(X(1, :), 'gaussian', 0, 0.5) * 2 - 1;
SX(:, 1) = noiseInput;
SY(:, 1) = sign(SX(:, 1)' * W);

for i = 2:epochs
    SX(:, i) = sign(W * SY(:, i - 1));
    SY(:, i) = sign(SX(:, i)' * W);
    if (sum(SX(:, epochs) == SX(:, epochs - 1)) == (KX1 * KX2) && ...
        sum(SY(:, epochs) == SY(:, epochs - 1)) == (KY1 * KY2))
        break;
    end
end

subplot(3, 1, 1)
imshow(reshape(SX(:, 1), KX1, KX2))
subplot(3, 1, 2)
imshow(reshape(SY(:, i), KY1, KY2))
subplot(3, 1, 3)
imshow(reshape(SX(:, i), KX1, KX2))