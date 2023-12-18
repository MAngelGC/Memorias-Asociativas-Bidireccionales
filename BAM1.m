clc;
clear;

X(1, :) = [1 1 1 -1 1 -1 -1 1 -1];
X(2, :) = [1 -1 -1 1 -1 -1 1 1 1];
Y(1, :) = [1 -1 -1];
Y(2, :) = [-1 -1 1];
W = X' * Y;

KX = size(X, 2);
KY = size(Y, 2);

epochs = 21;

SX = zeros(KX, epochs);
SY = zeros(KY, epochs);

SX(:, 1) = X(1, :);
SY(:, 1) = sign(SX(:, 1)' * W);

for i = 2:epochs
    SX(:, i) = sign(W * SY(:, i - 1));
    SY(:, i) = sign(SX(:, i)' * W);
    if (sum(SX(:, epochs) == SX(:, epochs - 1)) == KX && ...
        sum(SY(:, epochs) == SY(:, epochs - 1)) == KY)
        break;
    end
end