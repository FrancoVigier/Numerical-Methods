clc

clear

function pol = polinomioMinimosCuadrados(x0, y0, n)
    A = ones(1, size(x0,1))
    A = A'
    // Se inicializa la primer columna de A con 1s.
    // Segun el grado del polinomio se construyen las siguientes columnas
    // como corresponde.
    for i=1:n
        A = [A x0^i]
    end
    // Una vez se tiene la matriz, se calculan los coeficinetes del polinomio.
    pol = poly(inv(A'*A)*A'*y0, "x","coeff")
endfunction

x0 = [4 4.2 4.5 4.7 5.1 5.5 5.9 6.3 6.8 7.1]'
y0 = [102.56 113.18 130.11 142.05 167.53 195.14 224.87 256.73 299.5 326.72]'


function err = calculoError(x0, y0, polAprox)
    n = size(x0, 1)
    err = 0
    // Calculo de G
    for i=1:n
        err = err + (y0(i) - horner(polAprox, x0(i)))^2
    end
endfunction

// a)

disp(calculoError(x0,y0,polinomioMinimosCuadrados(x0, y0, 1)))
//   329.01319
disp(calculoError(x0,y0,polinomioMinimosCuadrados(x0, y0, 2)))
//   0.0014429
disp(calculoError(x0,y0,polinomioMinimosCuadrados(x0, y0, 3)))
//   0.0005273

// b)

rango = [min(x0):0.0001:max(x0)]
figure
plot(rango, horner(polinomioMinimosCuadrados(x0, y0, 1), rango),"b")
plot(x0, y0, "r*")
h1 = legend(['Grado 1'])
figure
plot(rango, horner(polinomioMinimosCuadrados(x0, y0, 2), rango),"b")
plot(x0, y0, "r*")
h1 = legend(['Grado 2'])
figure
plot(rango, horner(polinomioMinimosCuadrados(x0, y0, 3), rango),"b")
plot(x0, y0, "r*")
h1 = legend(['Grado 3'])

