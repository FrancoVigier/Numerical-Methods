clc

clear

// Ejercicio 

function y = Lk(x, k)
    [Xn,Xm] = size(x)
    
    // Se genera un vector con las raices del polinomio Lk
    r = [x(1:k-1) x(k+1:Xm)]
    // Con poly generamos el polinomio cuyas raices son r
    p = poly(r,"x","roots")
    // Evaluamos
    pk = horner(p, x(k))
    y = p / pk
endfunction

function z = interpolLagrange(x,y)
    [Xn,Xm] = size(x)
    pol = 0
    // Conformamos el polinomio de lagrange.
    for k = 1:Xm
        pol = pol + (Lk(x,k)*y(k))
    end
    z = pol
endfunction

/*
puntos x ->    [0,1,2,3]
puntos f(x) -> [1,3,3,?]


P02(0) = 1
P02(2) = 3
P01(1) = 3
P123(2.5) = 3

*/
x = [1,2,3]

L1 = Lk(x,1)
L2 = Lk(x,2)
L3 = Lk(x,3)

// P123(x) = L1(x)*3+L2(x)*3+L3(x)*k
// Sabiendo cuanto vale P123 en 2.5 tenemos la siguiente ecuacion.
// P123(2.5) = L1(2.5)*3+L2(2.5)*3+L3(2.5)*k = 3
// Resolviendo

disp(L1)
Comp1 = horner(L1,2.5)*3
Comp2 = horner(L2,2.5)*3
Comp3 = horner(L3,2.5)

k = (3-Comp1-Comp2)/Comp3

x = [0,1,2,3]
y = [1,3,3,k]

// Teniendo k calculamos el nuevo polinomio con todos los puntos.
P = interpolLagrange(x,y)
disp(k)
// Evaluamos en 2.5
res = horner(P, 2.5)

disp(res)
// 2.875
