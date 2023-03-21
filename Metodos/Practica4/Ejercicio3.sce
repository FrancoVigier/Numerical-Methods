clc
clear

function sol = triangular_sup(A, b)
    n = size(A)(1)
    x(n) = b(n)/A(n,n)
    for i=n-1:-1:1
        x(i) = (b(i) - A(i,i+1:n) * x(i+1:n))/A(i,i) 
    end
    sol = x
endfunction

// a)
function [s1, s2] = gaussSistemas(A, B)
    a = size(A)
    n = a(1)
    nb = size(B)(1)
    mb = size(B)(2)
    for k=1:(n-1)
        for j = (k+1):n
            mjk = A(j,k)/A(k,k)
            A(j, k) = 0
            // Elimino el for que recorre la fila entera
            // y utilizo la notacion de scilab para hacerlo.
            A(j, k+1:n) = A(j, k+1:n) - mjk * A(k, 1+k:n)
            // Actualizo todos los valores de la fila 
            // scorrespondiendte de la matriz B
            B(j, 1:mb) = B(j, 1:mb) - mjk * B(k, 1:mb)
        end
    end
    s1 = A
    // Realizo la sustitucion regresiva.
    for i=1:mb
        // Construyo la matriz con la sustitucion regresiva que corresponde
        // a cada sistema.
        s2(1:nb, i) =  triangular_sup(s1, B(1:nb, i))
    end
    
endfunction


/*
a)
    Ejemplos de ejecucion funcion gaussSistemas:


A = [1 -1 0;
    -1 2 -1;
     0 -1 1.1]
B = [1 2 3;
     1 2 3;
     1 2 3]
     
gaussSistemas(A, B) =
a =
   1.  -1.   0. 
   0.   1.  -1. 
   0.   0.   0.1
x =
   33.   66.   99.
   32.   64.   96.
   30.   60.   90.
   
------------------

A = [3 4 25;
     2 -9 -1;
     0 0 2]
B = [1 2 3;
     2 3 1;
     1 2 3]
     
gaussSistemas(A, B) =
a =
   3.   4.          25.      
   0.  -11.666667  -17.666667
   0.   0.          2.    

x =
  -2.6714286  -5.4571429  -8.5857143
  -0.8714286  -1.6571429  -2.1857143
   0.5         1.          1.5 
   
------------------

A = [3 6 2;
     5 9 7;
     1 3 6]
B = [1 2 3 1;
     1 2 3 1;
     1 2 3 1]

gaussSistemas(A, B) =
a =
   3.   6.   2.       
   0.  -1.   3.6666667
   0.   0.   9.       

x =
  -1.         -2.         -3.  -1.       
   0.6666667   1.3333333   2.   0.6666667
   0.          0.          0.   0.       
*/


// b)
A = [1 2 3;
     3 -2 1;
     4 2 -1]
B = [14 9 -2;
     2 -5 2;
     5 19 12]

disp("Sistema 1")
[a, x] =gaussSistemas(A, B)
disp(x, a)

/*
gaussSistemas(A, B) =

a =
   1.   2.   3.
   0.  -8.  -8.
   0.   0.  -7.

x =
   1.   2.   2.
   2.   5.   1.
   3.  -1.  -2.
*/

// c)
disp("c)")
// Igualar AX a la matriz identidad para conseguir la inversa.
A = [1 2 3;
     3 -2 1;
     4 2 -1]
B = [1 0 0;
     0 1 0;
     0 0 1]

[a, x] =gaussSistemas(A, B)
disp(x, a)
/*
a = 
   1.   2.   3.
   0.  -8.  -8.
   0.   0.  -7.
   
x =
   0.      0.1428571   0.1428571
   0.125  -0.2321429   0.1428571
   0.25    0.1071429  -0.1428571

Multiplicando x * A obtengo:

   1.   0.   0.
   0.   1.   0.
   0.   0.   1.
*/


