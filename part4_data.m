function dataterm = part4_data(Image_seq, D, Cam)
[hh, ww, ~]=size(Image_seq{1});
N = hh.*ww;
cc = length(D);
sum_graph = zeros(cc,N);
I1 = Image_seq{1};
K1 = Cam.K{1};
R1 = Cam.R{1};
T1 = Cam.T{1};
sigma_c = 30;
for IM=1:length(Image_seq)-1
    I2 = Image_seq{IM+1};
    K2 = Cam.K{IM+1};
    R2 = Cam.R{IM+1};
    T2 = Cam.T{IM+1};
    P4 = K2*R2.'*R1/K1; % from paper
    et_prm2 = K2*R2.'*(T1-T2); % from paper
    graph = zeros(cc,N);
    for y=1:hh
        for x=1:ww
            x1 = [x;y;1];
            pixel = y+(x-1)*hh;
            for class=1:cc
                x2 = P4*x1+D(class).*et_prm2;
                x2 = x2./x2(3);
                x2 = round(x2);
                if x2(1)>1&&x2(2)>1&&x2(1)<ww&&x2(2)<hh
                    graph(class, pixel) = sqrt(sum((I1(x1(2), x1(1), :)-I2(x2(2), x2(1), :)).^2, 3));
                else
                    graph(class, pixel) = sqrt(sum((I1(x1(2), x1(1), :)).^2, 3));
                end
            end
        end
    end
    similarity = sigma_c./(sigma_c+graph); % similar pixels have larger similarity with a maximum 1 and their values are chosen as ux, which finally make the dataterm is the smallest one. 
    sum_graph = sum_graph + similarity;
end
ux = max(sum_graph, [], 1);% same node, find the maximum disparity likelihood 1xN
dataterm = 1-sum_graph./ux;
dataterm(isnan(dataterm))=1;
end

