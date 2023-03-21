clc

clear


// Ejercicio 9

// Metodo de lagrange

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

function y=f(x)
    y = 1./(1+x.^2)
endfunction

rango = [-5:0.001:5]

// PLOTEO DE LA CURVA F(x) Y EL INTERPOLANTE Pn(x)
for i = 2:2:14
    if (i<>8 && i<>12)
        pol = interpolLagrange([-5:(10/(i-1)):5],f([-5:(10/(i-1)):5]))
        plot(rango, horner(pol, rango),"b")
        disp(pol,i)
        plot(rango, f(rango),"r")
        h1 = legend(['Grado '+string(i)])
        xgrid();
        
        figure
    end
end

// PLOTEO DE ERROR
for i = 2:2:14
    if (i<>8 && i<>12)
        pol = interpolLagrange([-5:(10/(i-1)):5],f([-5:(10/(i-1)):5]))
        plot(rango, abs(horner(pol,rango)-f(rango)),"b")
        h1 = legend(['Grado '+string(i)])
        figure
    end
end


/*
    Podemos ver que al aumentar el grado del polinomio, el error cerca 
    de 0 disminuye, pero en los extremos aumenta considerablemente.
    Atribuyo esto a el fenomeno de Runge.

*/
