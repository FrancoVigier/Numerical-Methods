clc

clear

// Ejercicio 5

// Toma matriz, vector inicial ALEATOREO de N entradas, tolerancia, cantidad maxima de iteraciones.
// Aproxima el mayotr autovalor de la matriz y su autovector DOMINANTE 
function [valor,zn]=potencia(A,z0,eps,max_iter)
    valor = 0
    iter = 1
    
    // Se realiza una primer iteracion
    w = A*z0
    zn = w/norm(w, %inf)
    
    [m, j]=max(abs(w))
    valor = m/zn(j)
    
    // Iteramos hasta conseguir la tolerancia, o hasta que se acaben las iteraciones.
    while ((iter < max_iter)&(norm(z0-zn, %inf) > eps))
        z0 = zn
        
        // Seguimos con el metodos segun la teoria.
        w = A*z0
        zn = w/norm(w, %inf)
        
        [m, j]=max(abs(w))
        valor = m/zn(j)
        
        // Aumentamos el contador de iteraciones
        iter = iter + 1
    end
    disp("iteraciones", iter)
endfunction

/*
    Ejemplos de ejecucion:
    
A = [1 0;
     0 1]
z0 = [1; 2]

[x,z]=potencia(A, z0, 0.0000001, 50)

 Autovalor

   1.

 Autovector

   0.5
   1.

 Autovalores segun scilab

   1.
   1.


A = [1 0 2;
     0 1 -2;
     5 1 3]
z0 = [1; 2; 6]

[x,z]=potencia(A, z0, 0.0000001, 50)

 Autovalor

   4.9999999

 Autovector

   0.5
  -0.5
   1.

 Autovalores segun scilab

   5.  
  -1.  
   1.

A = [-1 0 26;
     0 1 -2;
     55 1 -3]
z0 = [1; 0; 6]

[x,z]=potencia(A, z0, 0.0000001, 5000)

Reliza 5000 iteraciones.

 Autovalor

   39.803413

 Autovector

  -0.6700442
   0.0490155
   1.

 Autovalores segun scilab

  -39.803413  
   35.800596  
   1.0028169  
*/

// Es similar a la funcion anterior solo que termina en el caso en el que
// se encuentre la tolerancia pedida, de otro modo continuara la iteracion, 
// es util para comparar la velocidad de convergencia.
function [valor,zn]=potenciaError(A,z0,eps)
    valor = 0
    iter = 1
    
    // Se realiza una primer iteracion
    w = A*z0
    zn = w/norm(w, %inf)
    
    [m, j]=max(abs(w))
    valor = m/zn(j)
    autovalor = max(spec(A))
    // Iteracmos hasta alcanzar la tolerancia pedida.
    while (abs(valor-autovalor) > eps)
        z0 = zn
        // Seguimos con el metodos segun la teoria.
        w = A*z0
        zn = w/norm(w, %inf)
        
        [m, j]=max(abs(w))
        valor = m/zn(j)
        
        // Aumentamos el contador de iteraciones
        iter = iter + 1
    end
    disp("iteraciones", iter)
endfunction


disp("Matriz A1:")
A = [1 0 0 0;
     -0.002 0.999 -0.001 -0.001;
     -0.002 -0.002 0.998 -0.009;
     -0.003 -0.005 -0.003 0.997]

z0 = [1; 2; 3; 4]

[x,z]=potencia(A, z0, 0.0000001, 5000)

disp("Matriz a)")
disp("Autovalor")
disp(x)
disp("Autovector")
disp(z)
/*
   Iteraciones = 16.

   Radio espectral = 15.
   
   Autovector =
    1
    1
    1
    1
*/
disp("Autovalores segun scilab")
disp(spec(A))

/*
spec(A) =
  -1.
   5.
   5.
   15.
*/

disp("Matriz A2:")
B = [12 1 3 4
     1 -3 1 5;
     3 1 6 -2;
     4 5 -2 -1]

z0 = [1; 2; 3; 4]

[x,z]=potencia(B, z0, 0.001, 50)

disp("Matriz b)")
disp("Autovalor")
disp(x)
disp("Autovector")
disp(z)

/*
   Iteraciones = 12.

   Radio espectral = 14.199155
   
   Autovector =
   1.
   0.1556001
   0.318444
   0.272776
*/

disp("Autovalores segun scilab")
disp(spec(B))

/*
spec(B) =
  -7.6950877
   1.1939614
   6.3001206
   14.201006
*/


A = [1 0 0 0;
     0 1 0 0;
     0 0 1 0;
     0 0 0 1]

z0 = [1; 2; 3; 4]

disp("Matriz A errores")
// APARTADO B
disp(potenciaError(A, z0, %eps))
// resultado = 15.
// 33 iteraciones

B = [12 1 3 4
     1 -3 1 5;
     3 1 6 -2;
     4 5 -2 -1]

z0 = [1; 2; 3; 4]

disp("Matriz B errores")

disp(potenciaError(B, z0,%eps))

// resultado = 14.201006
// 57 iteraciones
