clc;
clear;
clf;

// ---------------- BASIC SETTINGS ----------------
n = 25;
A = zeros(n,n);

// ---------------- STAR TOPOLOGY (1–10) ----------------
for i = 2:10
    A(1,i)=1; A(i,1)=1;
end

// ---------------- RING TOPOLOGY (11–18) ----------------
for i = 11:17
    A(i,i+1)=1; A(i+1,i)=1;
end
A(18,11)=1; A(11,18)=1;

// ---------------- TREE TOPOLOGY (19–25) ----------------
A(19,20)=1; A(20,19)=1;
A(19,21)=1; A(21,19)=1;
A(20,22)=1; A(22,20)=1;
A(20,23)=1; A(23,20)=1;
A(21,24)=1; A(24,21)=1;
A(21,25)=1; A(25,21)=1;

// ---------------- CONNECT TOPOLOGIES ----------------
A(1,11)=1; A(11,1)=1;
A(1,19)=1; A(19,1)=1;

// ---------------- NODE POSITIONS ----------------
x = zeros(n,1);
y = zeros(n,1);

// STAR (center + circle)
theta = linspace(0,2*%pi,9);
x(1)=0; y(1)=0;
for i=2:10
    x(i)=cos(theta(i-1));
    y(i)=sin(theta(i-1));
end

// RING
theta = linspace(0,2*%pi,8);
for i=11:18
    x(i)=3+cos(theta(i-10));
    y(i)=sin(theta(i-10));
end

// TREE
x(19)=6; y(19)=0;
x(20)=5; y(20)=1;
x(21)=5; y(21)=-1;
x(22)=4; y(22)=1.5;
x(23)=4; y(23)=0.5;
x(24)=4; y(24)=-0.5;
x(25)=4; y(25)=-1.5;

// ---------------- DRAW GRAPH ----------------
scf(1);
clf(1);

// Draw edges
for i=1:n
    for j=i+1:n
        if A(i,j)==1 then
            plot([x(i) x(j)], [y(i) y(j)], 'b-');
        end
    end
end

// Draw nodes
plot(x, y, 'ro');

// Node labels
for i=1:n
    xstring(x(i)+0.05, y(i)+0.05, "N"+string(i));
end

xtitle("Hybrid Network Topology (Star + Ring + Tree)");

// ---------------- DEGREE CALCULATION ----------------
deg = sum(A,"r");
disp("Node Degrees:");
for i=1:n
    disp("Node "+string(i)+" : "+string(deg(i)));
end

[mx, node] = max(deg);
disp("Node with maximum edges: N"+string(node));
disp("Total Nodes: "+string(n));
disp("Total Edges: "+string(sum(A)/2));
