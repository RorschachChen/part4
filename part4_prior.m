function PAIRWISE = part4_prior(I1,ws,eps)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[hh, ww, ~] = size(I1);
t=1;
for y=1:hh
    for x=1:ww
        node = y+(x-1)*hh;
        Nx = 0;
        total_dist = 0;
        if y<hh
            I(1,t)=node;
            J(1,t)=node+1;
            Dist(1,t)=1./(eps+sqrt(sum((I1(y, x, :) - I1(y+1, x, :)).^2, 3)));
            total_dist = total_dist + Dist(1,t);
            Nx = Nx+1;
            t=t+1;
        end
        if y>1
            I(1,t)=node;
            J(1,t)=node-1;
            Dist(1,t)=1./(eps+sqrt(sum((I1(y, x, :) - I1(y-1, x, :)).^2, 3)));
            total_dist = total_dist + Dist(1,t);
            Nx = Nx+1;
            t=t+1;
        end
        if x<ww
            I(1,t)=node;
            J(1,t)=node+hh;
            Dist(1,t)=1./(eps+sqrt(sum((I1(y, x, :) - I1(y, x+1, :)).^2, 3)));
            total_dist = total_dist + Dist(1,t);
            Nx = Nx+1;
            t=t+1;
        end
        if x>1
            I(1,t)=node;
            J(1,t)=node-hh;
            Dist(1,t)=1./(eps+sqrt(sum((I1(y, x, :) - I1(y, x-1, :)).^2, 3)));
            total_dist = total_dist + Dist(1,t);
            Nx = Nx+1;
            t=t+1;
        end
        
        % 4 corners
        if x>1&&y>1
            I(1,t)=node;
            J(1,t)=node-hh-1;
            Dist(1,t)=1./(eps+sqrt(sum((I1(y, x, :) - I1(y-1, x-1, :)).^2, 3)));
            total_dist = total_dist + Dist(1,t);
            Nx = Nx+1;
            t=t+1;
        end
        
        if x>1&&y<hh
            I(1,t)=node;
            J(1,t)=node-hh+1;
            Dist(1,t)=1./(eps+sqrt(sum((I1(y, x, :) - I1(y+1, x-1, :)).^2, 3)));
            total_dist = total_dist + Dist(1,t);
            Nx = Nx+1;
            t=t+1;
        end
        
        if x<ww&&y>1
            I(1,t)=node;
            J(1,t)=node+hh-1;
            Dist(1,t)=1./(eps+sqrt(sum((I1(y, x, :) - I1(y-1, x+1, :)).^2, 3)));
            total_dist = total_dist + Dist(1,t);
            Nx = Nx+1;
            t=t+1;
        end
        
        if x<ww&&y<hh
            I(1,t)=node;
            J(1,t)=node+hh+1;
            Dist(1,t)=1./(eps+sqrt(sum((I1(y, x, :) - I1(y+1, x+1, :)).^2, 3)));
            total_dist = total_dist + Dist(1,t);
            Nx = Nx+1;
            t=t+1;
        end
        
        u_lambda = Nx./ total_dist;
        for i=1:Nx
            Dist(1, t-i)=Dist(1, t-i).*ws.*u_lambda;
        end
    end
end

PAIRWISE = sparse(I, J, Dist, hh*ww, hh*ww);
end

