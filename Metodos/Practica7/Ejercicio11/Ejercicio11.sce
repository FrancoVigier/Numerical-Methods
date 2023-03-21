clc

clear

// Ejercicio 11

// Funcion que toma el grado del polinomio y retorna la cantidad de
// raices necesarias.
function r = Chev(n)
    // Calculamos las n raices.
    for k=0:n-1
        // Seguimos con la formula de Chebyshev
        r(k+1) = cos(%pi/2*(1+2*k)/n)
    end
endfunction

// Funcion que mapea las raices de chev a nuestro intervalo [a,b]}
function rab = chev_ab(n, a, b)
    // Obtenemos las raices de Chebyshev
    r = Chev(n)
    for k=1:n
        // Caculamos la nueva raiz en [a,b]
        rab(k) = (r(k)*(b-a)+(a+b))/2
    end
endfunction

function dif = diferenciaDivididas(x, y, i, k)
    // Calculamos las diferencias divididas de forma recursiva,
    // al usarla hay que verivicar que k sea siempre distinto de 0,
    // lo cual no tiene sentido en la definicion de diferencias divididas.
    if k - i == 1 then
        dif = (y(k) - y(i)) / (x(k) - x(i))
    else 
        // Calculamos segun la formula del apunte (pag. 5)
        dif = (diferenciaDivididas(x, y, i+1, k) - diferenciaDivididas(x, y, i, k-1)) / (x(k) - x(i))
    end
endfunction

function p = InterpolacionNewton(x0, y0)
    // Obtenemos y guardamos el size
    [Xn, Xm] = size(x0)
    p = y0(1)
    for i=1:Xm-1
        p = p + poly(x0(1:i),"x","roots") * diferenciaDivididas(x0, y0, 1, i+1)
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
//DIFFERENCIA DIVIDIDA DE NEWTON ES MAS PRECISA QUE LAGRANGE
// Con los nodos obtenidos con Chebyshev mapeados a [a,b] calculamos el 
// polinomio de interpolacion de grado 3

p = InterpolacionNewton(chev_ab(4,0,%pi/2)',cos(chev_ab(4,0,%pi/2))')
disp(p)
/*
p =   0.9984416 +0.0319396x -0.6049283x^2  +0.1142627x^3 

*/
p1 = interpolLagrange(chev_ab(4,0,%pi/2)',cos(chev_ab(4,0,%pi/2))')
disp(p1)

rango = [0:0.001:%pi*10000]
plot(rango, horner(p,rango), 'r')
plot(rango, cos(rango), 'b')
plot(rango, horner(p1,rango), 'g')
h1 = legend(['Polinomio de grado 3 newton', 'cos(x)','Polinomio de grado 3 lagrange'])

figure
//plot(rango, abs(horner(p1, rango)-cos(rango)), 'g')
//plot(rango, abs(horner(p, rango)-cos(rango)), 'r')
plot(rango, abs((horner(p, rango)-cos(rango))-(horner(p1, rango)-cos(rango))), 'b')
h1 = legend(['Error del polinomio lagrange','Error del polinomio Newton','Dif de errores'])
xgrid()


