clc
clear

// necesario para ejercicio d)
function sol = triangular_sup(A, b)
    n = size(A)(1)
    x(n) = b(n)/A(n,n)
    for i=n-1:-1:1
        x(i) = (b(i) - A(i,i+1:n) * x(i+1:n))/A(i,i) 
    end
    sol = x
endfunction

function [x,a, cantI] = gausselim(A,b)
    // Esta función obtiene la solución del sistema de ecuaciones lineales A*x=b, 
    // dada la matriz de coeficientes A y el vector b.
    // La función implementa el método de Eliminación Gaussiana sin pivoteo.  
    
    [nA,mA] = size(A) 
    [nb,mb] = size(b)
    
    if nA<>mA then
        error('gausselim - La matriz A debe ser cuadrada');
        abort;
    elseif mA<>nb then
        error('gausselim - dimensiones incompatibles entre A y b');
        abort;
    end;
    cantI = 0
    a = [A b]; // Matriz aumentada
    
    // Eliminación progresiva
    n = nA;
    for k=1:n-1
        for i=k+1:n
            for j=k+1:n+1
                a(i,j) = a(i,j) - a(k,j)*a(i,k)/a(k,k);
                cantI = cantI + 3;
            end;
            for j=1:k        // no hace falta para calcular la solución x
                a(i,j) = 0;  // no hace falta para calcular la solución x
                             // cantI = cantI + 1;  No se si la igualacion a 0 cuenta.
            end              // no hace falta para calcular la solución x
        end;
    end;
    
    // Sustitución regresiva
    x(n) = a(n,n+1)/a(n,n);
    cantI = cantI + 1;
    for i = n-1:-1:1
        sumk = 0
        for k=i+1:n
            sumk = sumk + a(i,k)*x(k);
            cantI = cantI + 2;
        end;
        cantI = cantI + 2;
        x(i) = (a(i,n+1)-sumk)/a(i,i);
    end;
endfunction

// Ejemplos de aplicación
A = [3 -2 -1;
     6 -2 2;
     -9 7 1]
b = [0 6 -1]'

/*
gausselim(A,b) =

a =
   3.  -2.  -1. | 0.
   0.   2.   4. | 6.
   0.   0.  -4. |-4.

x =
   1.
   1.
   1.
*/

A = [1 1 0 3;
     2 1 -1 1;
     3 -1 -1 2;
    -1 2 3 -1]
b = [4 1 -3 4]'

/*
gausselim(A,b) =

a =
   1.   1.   0.   3. |  4. 
   0.  -1.  -1.  -5. | -7. 
   0.   0.   3.   13.|  13.
   0.   0.   0.  -13.| -13.
   
x =
  -1.
   2.
   0.
   1.
*/

A = [0 2 3;
     2 0 3;
     8 16 -1]
b = [7 13 -3]'

/*
gausselim(A,b) =
a =
   0.   2.    3.    7. 
   0.  -Inf  -Inf  -Inf
   0.   0.    Nan   Nan

x =
   Nan
   Nan
   Nan

En este caso, claramente se genero un pivote nulo lo cual hizo que la 
sustitucion regresiva falle.
*/

A = [1 -1 2 -1;
     9 -2 3 -3;
     12 5 1 0;
     1 -1 4 3]
b = [-8 -20 -2 4]'

/*
gausselim(A,b) =

a = 
   1.  -1.   2.         -1.        |-8.       
   0.   7.  -15.         6.        | 52.      
   0.   0.   13.428571  -2.5714286 |-32.285714
   0.   0.   0.          4.3829787 | 16.808511

x =
  -0.2621359
   0.5631068
  -1.6699029
   3.8349515
*/

//----------------------------------------------------------------------

// b)

// i)


A2 = [1 1 0 3; 2 1 -1 1; 3 -1 -1 2; -1 2 3 -1]
b2 = [4 1 -3 4]'

disp("i)")
[x, A] = gausselim(A2,b2)
disp(x, A)

/*
gausselim(A2,b2) =
a =
   1.   1.   0.   3. |  4. 
   0.  -1.  -1.  -5. | -7. 
   0.   0.   3.   13.|  13.
   0.   0.   0.  -13.| -13.
   
x =
  -1.
   2.
   0.
   1.
*/

// ii)

A2 = [1 -1 2 -1; 2 -2 3 -3; 1 1 1 0; 1 -1 4 3]
b2 = [-8 -20 -2 4]'

disp("ii)")
[x, A] = gausselim(A2,b2)
disp(x, A)

/*
    En este apartado, el algoritmo divide por 0 por lo tanto no es correcto.
    Un pivote resulta igual a 0 y el algoritmo no esta preparado para lidiar.
*/

// iii)

A2 = [1 1 0 4; 2 1 -1 1; 4 -1 -2 2; 3 -1 -1 2]
b2 = [2 1 0 -3]'

disp("iii)")
[x, A] = gausselim(A2,b2)
disp(x, A)

/*
gausselim(A2,b2) =
a =
   1.   1.   0.   4. |  2.
   0.  -1.  -1.  -7. | -3.
   0.   0.   3.   21.|  7.
   0.   0.   0.  -3. | -4.
   
x =
  -4.
   0.6666667
  -7.
   1.3333333
*/

// c)

// Hice que la funcion le sume a una varible la cantidad de operaciones 
// que se hacen en cada caso.

disp("Ejemplo ejercicio c matriz del iii)")
[x, A, i] = gausselim(A2,b2)
disp(x, A, i)
// Se realizan 79 operaciones

// d)

function [s1, s2] = gauss(A, b)
    a = size(A)
    n = a(1)
    for k=1:(n-1)
        for j = (k+1):n
            mjk = A(j,k)/A(k,k)
            A(j, k) = 0
            // Elimino el for que recorre la fila entera
            // y utilizo la notacion de scilab para hacerlo.
            A(j, k+1:n) = A(j, k+1:n) - mjk * A(k, 1+k:n)
            b(j) = b(j) - mjk * b(k)
        end
    end
    s1 = A
    // Realizo la sustitucion regresiva.
    s2 = triangular_sup(A, b)
endfunction


// i)

A2 = [1 1 0 3; 2 1 -1 1; 3 -1 -1 2; -1 2 3 -1]
b2 = [4 1 -3 4]'

disp("Ejemplos ejercicio d)-i)")
[x, A] = gauss(A2,b2)
disp(x, A)

/*
gauss(A2,b2) =

a =
   1.   1.   0.   3. 
   0.  -1.  -1.  -5. 
   0.   0.   3.   13.
   0.   0.   0.  -13.
   
x =
  -1.
   2.
   0.
   1.
*/

// ii)

A2 = [1 -1 2 -1; 2 -2 3 -3; 1 1 1 0; 1 -1 4 3]
b2 = [-8 -20 -2 4]'

disp("ii)")
[x, A] = gauss(A2,b2)
disp(x, A)

/*
    En este apartado, el algoritmo divide por 0 por lo tanto no es correcto.
    Un pivote resulta igual a 0 y el algoritmo no esta preparado para lidiar.
*/

// iii)

A2 = [1 1 0 4; 2 1 -1 1; 4 -1 -2 2; 3 -1 -1 2]
b2 = [2 1 0 -3]'

disp("iii)")
[x, A] = gauss(A2,b2)
disp(x, A)


/*
gauss(A2,b2) =

a =
   1.   1.   0.   4. 
   0.  -1.  -1.  -7. 
   0.   0.   3.   21.
   0.   0.   0.  -3. 

x =
  -4.
   0.6666667
  -7.
   1.3333333

*/

