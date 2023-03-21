clc

clear

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


//compare la diferencia entre el autovalor aproximado por
//el metodo de la potencia y el mayor autovalor
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
    //RADIO ESPECTRAL
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




//EJJEMPLO DE USO

disp("Matriz A1:")
A = [6 4 4 1;
     4 6 1 4;
     4 1 6 4;
     1 4 4 6]

z0 = [1; 2; 3; 4]

[x,z]=potencia(A, z0, 0.0000001, 5000)

disp("Matriz a)")
//EL MAX AUTOVALOR ES EL RADIO ESPECTRAL
disp("Autovalor")
disp(x)
disp("Autovector")
disp(z)
//SEGUN SCILAB
disp(max(spec(A)))
//___________________________
B = [12 1 3 4;
     1 -3 1 5;
     3 1 6 -2;
     4 5 -2 -1]

z0 = [1; 2; 3; 4]

disp("Matriz B errores")

[y,w]=potenciaError(B, z0,%eps)
disp("Autovalor")
disp(y)
disp("Autovector")
disp(w)
