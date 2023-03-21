clc

clear

// Ejercicio 10

// f(x) = e^x en [-1,1]

// Funcion que calcula los nodos de raices segun el grado.
function r = Chev(n)
    for k=0:n-1
        r(k+1) = cos(%pi/2*(1+2*k)/n)
    end
endfunction

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

disp("Raices de Chev")
disp(Chev(4))
disp(exp(Chev(4)))
/*
   Chev(4) =
   0.9238795
   0.3826834
  -0.3826834
  -0.9238795
   
   exp(Chev(4) =
   2.5190442
   1.4662138
   0.6820288
   0.396976

  
*/

pol3 = interpolLagrange(Chev(4)', exp(Chev(4)'))
disp(pol3)
//pol3 = 0.9946153 +0.9989332x +0.5429007x^2 +0.1751757x^3

rango = [-1:0.001:1]
figure 
plot(rango, horner(pol3, rango), 'r') // HORNER VALORIZA Pol3(x) para todo x en [-1:0.001:1]
plot(rango, exp(rango), 'b')
xgrid()
h1 = legend(['Polinomio Interpolacion','f(x)'])

figure
plot(rango, abs(horner(pol3, rango)-exp(rango)), 'r')
h1 = legend(['Error del polinomio'])
xgrid()

/*
figure
polConstante = interpolLagrange([-1:2/3:1], exp([-1:2/3:1]))
plot(rango, abs(horner(polConstante, rango)-exp(rango)), 'r')
h1 = legend(['Error del polinomio'])
xgrid()
*/

