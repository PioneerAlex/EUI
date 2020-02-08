%% ex1 - AR(2)
syms x y z
eqn1 = x - 1.3 * y + 0.4 * z == 1;
eqn2 = 1.3 * x - y - 0.4 * z == 0;
eqn3 = 0.4 * x - 1.3 * y + z == 0;

[A,B] = equationsToMatrix([eqn1, eqn2, eqn3], [x, y, z])

X = linsolve(A,B)