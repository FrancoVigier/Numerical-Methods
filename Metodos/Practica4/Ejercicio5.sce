clc
clear

function [x,a] = gausselimPP(A,b)
// Esta función obtiene la solución del sistema de ecuaciones lineales A*x=b, 
// dada la matriz de coeficientes A y el vector b.
// La función implementa el método de Eliminación Gaussiana con pivoteo parcial.

[nA,mA] = size(A) 
[nb,mb] = size(b)

if nA<>mA then
    error('gausselim - La matriz A debe ser cuadrada');
    abort;
elseif mA<>nb then
    error('gausselim - dimensiones incompatibles entre A y b');
    abort;
end;

a = [A b]; // Matriz aumentada
n = nA;    // Tamaño de la matriz
// Eliminación progresiva con pivoteo parcial
for k=1:n-1
    
    // pivoteo
    kpivot = k; 
    amax = abs(a(k,k));  
    for i=k+1:n
        if abs(a(i,k))>amax then // se encuentra el mayor elemento 
                                 //debajo del pivote
            kpivot = i; // si se enecuetra se guarda la fila
            amax = abs(a(i,k)); // y se actualiza el mayor acutal
        end;
    end;
    // Se realiza el intercambio de filas.
    temp = a(kpivot,:);
    a(kpivot,:) = a(k,:);
    a(k,:) = temp;
    
    // Eliminacion como en el algortim sin pivoteo
    for i=k+1:n
        for j=k+1:n+1
            a(i,j) = a(i,j) - a(k,j)*a(i,k)/a(k,k);
        end;
    end;
end;

// Sustitución regresiva
x(n) = a(n,n+1)/a(n,n);
for i = n-1:-1:1
    sumk = 0
    for k=i+1:n
        sumk = sumk + a(i,k)*x(k);
    end;
    x(i) = (a(i,n+1)-sumk)/a(i,i);
end;
endfunction
    
// Ejemplo de aplicación

A2 = [0 2 3; 2 0 3; 8 16 -1]
b2 = [7 13 -3]'

[x2,a2] = gausselimPP(A2,b2)
disp(x2, a2)

/*
gausselimPP(A2,b2) =

a =
   8.   16.  -1.     -3.    
   2.  -4.    3.25    13.75 
   0.   2.    4.625   13.875

La matriz a no es triangular superior pues ahorramos ese paso en el 
algoritmo, pero la sustitucion regresiva solo toma en cuenta la triangular
superior

x =
   2.
  -1.
   3.
*/

// b)

// i)

A2 = [1 1 0 3; 2 1 -1 1; 3 -1 -1 2; -1 2 3 -1]
b2 = [4 1 -3 4]'

disp("i)")
[x, A] = gausselimPP(A2,b2)
disp(x, A)

/*
gausselimPP(A2,b2) =

a =

   3.  -1.         -1.          2.        |-3. 
  -1.   1.6666667   2.6666667  -0.3333333 | 3. 
   2.   1.6666667  -3.          0.        | 0. 
   1.   1.3333333  -1.8         2.6       | 2.6

x =
  -1.
   2.
   1.850D-17
   1.
*/

// ii)

A2 = [1 -1 2 -1; 2 -2 3 -3; 1 1 1 0; 1 -1 4 3]
b2 = [-8 -20 -2 4]'

disp("ii)")
[x, A] = gausselimPP(A2,b2)
disp(x, A)


/*
gausselimPP(A2,b2) =

a =

   2.  -2.   3.   -3.  |-20.
   1.   2.  -0.5   1.5 | 8. 
   1.   0.   2.5   4.5 | 14.
   1.   0.   0.5  -0.4 |-0.8

x =
  -7.
   3.
   2.
   2.
*/

// iii)

A2 = [1 1 0 4; 2 1 -1 1; 4 -1 -2 2; 3 -1 -1 2]
b2 = [2 1 0 -3]'

disp("iii)")
[x, A] = gausselimPP(A2,b2)
disp(x, A)


/*
gausselimPP(A2,b2) =

a =

   4.  -1.    -2.    2.  | 0.       
   2.   1.5    0.    0.  | 1.       
   1.   1.25   0.5   3.5 | 1.1666667
   3.  -0.25   0.5  -3.  |-4.

x =
  -4.
   0.6666667
  -7.
   1.3333333

*/


