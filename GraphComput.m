function LABELS = GraphComput(image_flow, cam)
[h1, w1, ~] = size(image_flow{1});
C = 101;
Dmax = 0.08;
D = linspace(0, Dmax, C);
[X, Y] = meshgrid(1:C, 1:C);
labelcost = min(abs(X-Y), 1);
w = 5;
Ws = w ./ Dmax;
Eps = 50;
tic; fprintf('  - computing data term.');
data_term = part4_data(image_flow, D, cam);
fprintf(' (%.1fmin)\n', toc/60);

tic; fprintf('  - computing prior term.');
pairwise_term = part4_prior(image_flow{1}, Ws, Eps);
fprintf(' (%.1fmin)\n', toc/60);

tic; fprintf('  - optimizing by graph-cut.');
[~, Segclass] = min(unary, [], 1);
Segclass = Segclass - 1;
LABELS = GCMex(Segclass, single(data_term), pairwise_term, single(labelcost),0) + 1;
fprintf(' (%.1fmin)\n', toc/60);
LABELS = reshape(LABELS, [h1, w1]);
LABELS = LABELS ./ C .* 255;
end

