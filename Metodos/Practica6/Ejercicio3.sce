clc

clear

// Ejercicio 3

A = [1 -1 0;
    -2 4 -2;
     0 -1 1]

for i=0:10
    // Se inicializa A
    E = A
    // Se le asigana en la posicion (3,3) el valor pedido.
    E(3,3) = A(3,3)+ 0.1*i
    disp("e = "+string(i))
    // Con la funcion poly se calcula el polinomio caracteristico.
    p = poly(A,'x')
    disp(p)
    // Calculamos sus raices.
    disp(roots(p))
    // Y comapramos con los autovalores
    disp(spec(A))
end

/*
 e = 0

                    2   3
  -3.176D-16 +5x -6x  +x 

Roots =
   5.  
   1.  
   0.  
Spec =
   5.  
   1.  
   0.  

 e = 1

                    2   3
  -3.176D-16 +5x -6x  +x 

Roots =
   5.  
   1.  
   0.  

Spec =
   5.  
   1.  
   0.  

 e = 2

                    2   3
  -3.176D-16 +5x -6x  +x 

Roots =
   5.  
   1.  
   0.  

Spec =
   5.  
   1.  
   0.  
   
 e = 3

                    2   3
  -3.176D-16 +5x -6x  +x 

Roots =
   5.  
   1.  
   0.  

Spec =
   5.  
   1.  
   0.  

 e = 4

                    2   3
  -3.176D-16 +5x -6x  +x 

Roots =
   5.  
   1.  
   0.  

Spec =
   5.  
   1.  
   0.  

 e = 5

                    2   3
  -3.176D-16 +5x -6x  +x 

Roots =
   5.  
   1.  
   0.  

Spec =
   5.  
   1.  
   0.  

 e = 6

                    2   3
  -3.176D-16 +5x -6x  +x 

Roots =
   5.  
   1.  
   0.  

 e = 7

                    2   3
  -3.176D-16 +5x -6x  +x 

   5.  
   1.  
   0.  

Spec =
   5.  
   1.  
   0.  
Spec =
   5.  
   1.  
   0.  

 e = 8

                    2   3
  -3.176D-16 +5x -6x  +x 

Roots =
   5.  
   1.  
   0.  

Spec =
   5.  
   1.  
   0.  

 e = 9

                    2   3
  -3.176D-16 +5x -6x  +x 

   5.  
   1.  
   0.  

Spec =
   5.  
   1.  
   0.  

 e = 10

                    2   3
  -3.176D-16 +5x -6x  +x 

Roots =
   5.  
   1.  
   0.  

Spec =
   5.  
   1.  
   0.  

*/
