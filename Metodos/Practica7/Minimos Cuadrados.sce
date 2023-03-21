clc

clear

// Ejercicio 7

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

x0 = [0 0.15 0.31 0.5 0.6 0.75]'
y0 = [1 1.004 1.31 1.117 1.223 1.422]'
// __________________________________
A = [1 0;
     1 0.15;
     1 0.31;
     1 0.5;
     1 0.6;
     1 0.75]

b = [1 1.004 1.31 1.117 1.223 1.422]'

x = inv(A'*A)*A'*b

disp(x,"Grado 1:")
    
A2 = [A A(:,2)^2]

x = inv(A2'*A2)*A2'*b

disp(x,"Grado 2:")

A3 = [A A(:,2)^2 A(:,2)^3]

x = inv(A3'*A3)*A3'*b

disp(x,"Grado 3:")
// _____________________________________
disp(polinomioMinimosCuadrados(x0, y0, 1))
//   0.9960666 +0.4760174x

disp(polinomioMinimosCuadrados(x0, y0, 2))
//   0.9960666 +0.4760174x^2

disp(polinomioMinimosCuadrados(x0, y0, 3))
//   0.9653196 +1.6154731x -4.3450249x^2  +3.97241x^3


rango = [-0:0.0001:1]
plot(rango, horner(polinomioMinimosCuadrados(x0, y0, 1), rango),"r")
plot(x0, y0, "r*")
h1 = legend(['Grado 1'])
figure
plot(rango, horner(polinomioMinimosCuadrados(x0, y0, 2), rango),"g")
plot(x0, y0, "r*")
h1 = legend(['Grado 2'])
figure
plot(rango, horner(polinomioMinimosCuadrados(x0, y0, 3), rango),"b")
plot(x0, y0, "r*")
h1 = legend(['Grado 3'])

/*
    Claramente la mejor aproxmacion es la de grado 3.
*/

