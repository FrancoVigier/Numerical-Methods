clc

clear

// Necesarias para resolver sistemas con matrices triangulares
function sol = triangular_sup(A, b)
    n = size(A)(1)
    x(n) = b(n)/A(n,n)
    for i=n-1:-1:1
        x(i) = (b(i) - A(i,i+1:n) * x(i+1:n))/A(i,i) 
    end
    sol = x
endfunction

function sol = triangular_inf(A, b)
    n = size(A)(1)
    x(1) = b(1)/A(1,1)
    for i=2:1:n
        x(i) = (b(i) - A(i,1:i-1) * x(1:i-1))/A(i,i)
    end
    sol = x
endfunction

// Metodo de dolittle
function [L,U] = dolittle(A)
    n = size(A,1)
    L = eye(n,n)
    U = zeros(n,n)
    
    U(1,:) = A(1,:)
    for k = 1:n
        for j = k:n
            suma = L(k,1:k-1)*U(1:k-1,j)
            if suma == []
                suma = 0
            end
            U(k,j) = A(k,j) - suma
        end
        
        for i = k+1:n
            suma = L(i,1:k-1)*U(1:k-1,k)
            if suma == [] 
                suma = 0
            end
            L(i,k)=(A(i,k) - suma)/U(k,k)
        end
    end
endfunction

disp("Ejemplo 1")
A = [2 2 4;2 2 3;3 0 1]
[L, U] =dolittle(A)
disp(L * U)

/*
Se muestra:

   2.    2.    Nan
   2.    2.    Nan
   Nan   Nan   Nan
   
esto es ya que el algoritmo no esta preparado para tenesr pivotes nulos

*/

disp("Ejemplo 2")
A = [2 2 4;2 5 3;3 0 1]
[L, U] =dolittle(A)
disp(L)
disp(U)
disp(L*U)
/*
L =
   1.    0.   0.
   1.    1.   0.
   1.5  -1.   1.
U =
   2.   2.   4.
   0.   3.  -1.
   0.   0.  -6.

L*U =
   2.   2.   4.
   2.   5.   3.
   3.   0.   1.
*/

disp("Ejemplo 3")
A = [2 2 4 5;2 5 3 9 ;3 0 1 10;-8 2 -1 10]
[L, U] =dolittle(A)
disp(L)
disp(U)
disp(L*U)
/*
L =
   1.    0.          0.          0.
   1.    1.          0.          0.
   1.5  -1.          1.          0.
  -4.    3.3333333  -3.0555556   1.
U =

   2.   2.   4.   5.       
   0.   3.  -1.   4.       
   0.   0.  -6.   6.5      
   0.   0.   0.   36.527778

L*U =
   2.   2.   4.   5. 
   2.   5.   3.   9. 
   3.   0.   1.   10.
  -8.   2.  -1.   10.

*/

disp("Ejercicio")
A = [1 2 3 4;1 4 9 16;1 8 27 64;1 16 81 256]
b = [2;10;44;190]

[L, U] = dolittle(A)

// Lo que se hace es resolver un sistema equivalente a Ax = b
// (LU) x = b => Ly = b y luego Ux = y. Lo cual resulta mas simple pues
// L como U son triangulares.

disp(triangular_sup(U,triangular_inf(L,b)))

/* Resultado = 
  -1.
   1.
  -1.
   1.
*/
