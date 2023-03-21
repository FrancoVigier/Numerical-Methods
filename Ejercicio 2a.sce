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

x0 = [0.2 0.3 0.9 1.3 1.6]'
y0 = [0.050446 0.098426 0.7266 1.5694 2.5015]'

//Realizo la conformacion de matrices A,x,b según el teorema 2 de minimos cuadrados, para comparar las soluciones
A = [1 0.2;
     1 0.3;
     1 0.9;
     1 1.3;
     1 1.6]
b = [0.050446 0.098426 0.7266 1.5694 2.5015]'
//Aplico el teorema 2
x = inv(A'*A)*A'*b

//Aplico ahora la funcion de minimos cuadrados para contrastar los resultados
disp(x,"Grado 1:")
disp(polinomioMinimosCuadrados(x0, y0, 1))

//Ploteo los puntos y la lineal
rango = [-0:0.0001:2]
plot(rango, horner(polinomioMinimosCuadrados(x0, y0, 1), rango),"r")
plot(x0, y0, "r*")
h1 = legend(['Grado 1'])
figure


/* SALIDA
 -0.4415403
   1.663738 

  "Grado 1:"

  -0.4415403 +1.663738x

*/
//Comparando los resultados están iguales

