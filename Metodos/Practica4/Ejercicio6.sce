clc

clear

// Ejercicio 6

// A matriz tridiagonal

function [x,a] = gausselimPPTridiagonal(A,b)
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
contador = 0;
for k=1:n-1
    // Se chequea si el elemento debajo del pivote es mayor.
    if (abs(a(k, k)) < abs(a(k + 1, k)))
        // Se realiza el intercambio de filas.
        temp = a(k + 1,:);
        a(k + 1,:) = a(k,:);
        a(k,:) = temp;
    end
    
    // Se eliminan solo las posiciones donde puede haber elementos
    // distintos de 0.
    mkk = a(k+1,k)/a(k,k)
    contador = contador + 1;
    // a(k+1, k) = 0 si se agrega esta linea, queda la matriz a triangular superior.
    a(k+1,k+1) = a(k+1,k+1) - mkk*a(k,k+1);
    contador = contador + 2;
    // se chequea para no exeder el rango de la matriz.
    if (k+2 <= n)
        a(k+1,k+2) = a(k+1,k+2) - mkk*a(k,k+2);
        contador = contador + 2;
    end
    a(k+1,n+1) = a(k+1,n+1) - mkk*a(k,n+1);
    contador = contador + 2;

end;

// Sustitución regresiva
x(n) = a(n,n+1)/a(n,n);
contador = contador + 1;
for i = n-1:-1:1
    // los if son para que al eliminar no accedamos a la parte de la 
    // matriz extendida en la cual esta b. Otras vez, solo tomamos en 
    // cuenta los valores donde no hay 0.
    if i == n-1
        x(i) = (a(i,n+1)-a(i,i+1)*x(i+1))/a(i,i);
        contador = contador + 3;
    else
        if i == n-2
            x(i) = (a(i,n+1)-a(i,i+1)*x(i+1)-a(i,i+2)*x(i+2))/a(i,i);
            contador = contador + 5;
        else
            x(i) = (a(i,n+1)-a(i,i+1)*x(i+1)-a(i,i+2)*x(i+2)-a(i,i+3)*x(i+3))/a(i,i);
            contador = contador + 7;
        end
    end
end;
disp(contador,"Operaciones:")

endfunction


A = [1 2 0 0 0; 3 1 2 0 0; 0 3 1 2 0; 0 0 3 1 2; 0 0 0 3 1]
b= [-8 -20 -2 4 5]'

[a, x] = gausselimPPTridiagonal(A, b)
disp(x, a)

/*
gausselimPPTridiagonal(A, b)
49 operaciones

a =
   3.   1.          2.          0.          0.         -20.      
   0.   3.          1.          2.          0.         -2.       
   0.   0.          3.          1.          2.          4.       
   0.   0.          0.          3.          1.          5.       
   1.   1.6666667  -1.2222222  -0.7037037   1.0493827   2.5802469
   
Notese que la matriz a no es triangular inferior, ya que para ahorrar
operaciones no establezco en 0 los elementos debajo de los pivotes, solo
los ignoro cuando hago sustitucion regresiva

x =
  -5.9294118
  -1.0352941
  -0.5882353
   0.8470588
   2.4588235

*/

A = [1 2 0 0;
     3 1 2 0;
     0 3 1 2;
     0 0 3 1]
b= [-8 -20 -2 4]'

[a, x] = gausselimPPTridiagonal(A, b)
disp(x, a)

/*
gausselimPPTridiagonal(A, b)
35 operaciones

a =
   3.   1.          2.          0.         -20.      
   0.   3.          1.          2.         -2.       
   0.   0.          3.          1.          4.       
   1.   1.6666667  -1.2222222  -0.7037037   1.4074074

x =
  -8.
  -4.441D-16
   2.
  -2.
*/

A = [1 2;
     3 1]
b= [-8 -20]'

[a, x] = gausselimPPTridiagonal(A, b)
disp(x, a)

/*
gausselimPPTridiagonal(A, b)
9 operaciones

a =
   3.   1.         -20.      
   1.   1.6666667  -1.3333333

x =
  -6.4
  -0.8

*/

