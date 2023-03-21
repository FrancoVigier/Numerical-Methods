clc

clear

// Ejercicio 4


/*
x       2.0     2.1     2.2     2.3     2.4     2.5
J0(x)   0.2239  0.1666  0.1104  0.0555  0.0025  −0.0484
*/

// Hallar J0(2.15) J0(2.35)

// Newton

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
    // Obtenemos y guardamos el tamaño
    [Xn, Xm] = size(x0)
    // calculamos el primer coeficiente
    p = y0(1)
    for i=1:Xm-1
        // formula del polinomio de newton.
        p = p + poly(x0(1:i),"x","roots") * diferenciaDivididas(x0, y0, 1, i+1)
    end

endfunction

// J0(2.15)
disp("J0(2.15)")

x0 = [2.0 2.1 2.2 2.3 2.4 2.5]
y0 = [0.223 0.1666 0.1104 0.0555 0.0025 -0.0484]
p = InterpolacionNewton(x0, y0)
y = horner(p, 2.15)
disp(y)
// y = 0.1383934

// J0(2.35)
disp("J0(2.35)")
x0 = [2.0 2.1 2.2 2.3 2.4 2.5]
y0 = [0.223 0.1666 0.1104 0.0555 0.0025 -0.0484]
p = InterpolacionNewton(x0, y0)
y = horner(p, 2.35)
disp(y)
// y = 0.0287418



