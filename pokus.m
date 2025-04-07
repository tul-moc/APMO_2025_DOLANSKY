
L = 0.1;
W = 0.02;

R1 = [3;4; 0;L;L;0;         0;0;W;W];
R2 = [3;4; L;L+W;L+W;L;     0;0;W;W];
R3 = [3;4; L+W;2*L+W;2*L+W;L+W; 0;0;W;W];

gd = [R1, R2, R3];
ns = ['R1'; 'R2'; 'R3']';
sf = 'R1+R2+R3';
[g, bt] = decsg(gd, sf, ns);

% Inicializace PDE
[p,e,t] = initmesh(g, 'Hmax', 0.005);
[p,e,t] = refinemesh(g,p,e,t);

% Koeficienty problému
c = 100; % vodivost (1 / 0.01)
a = 0;
f = 0;

% Dirichletovy okrajové podmínky: najdeme hrany vlevo a vpravo
% Získání souřadnic okrajů
x1 = p(1,e(1,:));
x2 = p(1,e(2,:));

% Levý okraj: x ≈ 0
leftEdges = find( abs(x1) < 1e-5 & abs(x2) < 1e-5 );

% Pravý okraj: x ≈ 0.22 (2L+W)
rightEdges = find( abs(x1 - (2*L + W)) < 1e-5 & abs(x2 - (2*L + W)) < 1e-5 );

% Inicializace Dirichlet podmínek
nNodes = size(p,2);
uD = NaN(1, nNodes); % NaN = neurčená hodnota

% Nastavíme 5V na levý okraj
leftNodes = unique(e(1,leftEdges));
uD(leftNodes) = 5;

% 4.5V na pravý okraj
rightNodes = unique(e(1,rightEdges));
uD(rightNodes) = 4.5;

% Řešení pomocí assempde
u = assempde(bndcond(uD), p, e, t, c, a, f);

% Vizualizace výsledků
pdeplot(p,e,t,'XYData',u,'Contour','on','ColorMap','jet');
title('Rozložení elektrického potenciálu (V)');
xlabel('x [m]');
ylabel('y [m]');
colorbar;

% Gradient (proudová hustota J = -sigma * grad(u))
[ux, uy] = pdegrad(p,t,u);
Jx = -c * ux;
Jy = -c * uy;

% Zobrazení proudu
figure;
pdeplot(p,e,t,'FlowData',[Jx;Jy]);
title('Vektorové pole hustoty proudu');
xlabel('x [m]');
ylabel('y [m]');
