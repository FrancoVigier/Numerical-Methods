clc
clear

/*
    Calcula el maximo valor absuluto de los autovalores
    de la matriz A
*/
function y=radioEspectral(A)
    y = max(abs(spec(A)))
endfunction

/*
    Funcion que chequea si la matriz es diagonal dominante, es decir
    si |A(i,i)| > sumatoria j = 1 a n con j distinto a i de |A(i,j)|
*/
function res = diagonalDominante(A)
    [nA, mA] = size(A)
    
    // Por cada columna chequeamos la condicion.
    for i = 1:nA
        suma = 0
        // Ciclo que realiza la sumatoria de los elementos de la fila
        // distintos de la diagonal.
        for j = 1:mA
            if j <> i
                suma = suma + abs(A(i,j))
            end
        end
        // Chequeo si la suma no cumple la condicion, si no lo hace la 
        // matriz no es diagonal dominante.
        if suma >= abs(A(i,i))
            res = 0
            return
        end
    end
    res = 1
endfunction

/*
    I = eye(3,3)
    diagonalDominante(I) = 1
    A = [5 2 2; 1 6 2; 1 1 6]
    diagonalDominante(A) = 1
    B = [5 2 3; 1 6 2; 1 1 6]
    diagonalDominante(B) = 0
    C = [1 6 2; 1 1 6;5 2 3]
    diagonalDominante(C) = 0
*/

/*
    Funcion que dada una matriz y la matriz del metodo, teste si el
    mismo convergera para todo x0 incial bajo el metodo correspondiente.
*/
function res = metodoTest(A, N)
    
    // Primera condicion si la matriz es diagonal diagonal.
    if diagonalDominante(A) == 1
        res = 1
        disp("Matriz diagonal dominante")
        return
    end
    
    // Si no es diagonal chequeo la acotacion de las normas de la
    // matiz de iteracion.
    
    if det(N) == 0
        res = 0
        disp("Matriz N singular")
        return
    end
    
    n = size(A)(1)
    I = eye(n,n)
    // Calculo de matriz de iteracion.
    matrizItera = I - inv(N)* A
    n(1) = norm(matrizItera, 1)
    n(2) = norm(matrizItera, 'inf')
    n(3) = norm(matrizItera, 'fro')
    n(4) = norm(matrizItera)
    if min(n) < 1
        res = 1
        disp("Matriz con alguna norma acotada por 1")
        return
    end
    
    // Si las normas no estan acotadas, verifico si el radio 
    // espectral si.
    if radioEspectral(matrizItera) < 1
        res = 1
        disp("Radio espectral acotado por 1")
        return
    end
    
    // Si llegamos aca es que no se cumplio ninguna condicion de 
    // convergencia.
    res = 0
     
endfunction

function x = gaussseidel(A,b,x0,eps)  
    n = size(A,1)
    x = x0
    xant = x
    // Buffer de la sumatoria.
    suma = 0
    // Contador de iteraciones.
    cont = 0
    
    while(abs(norm(x-xant)) > eps | cont == 0) 
    xant = x
        for i = 1:n
            suma = 0
            // Sumatoria
            for j = 1:n 
                if (i<>j)
                    suma = suma + A(i,j)*x(j)
                end
            end

            x(i) = 1/(A(i,i))*(b(i)-suma)
        end
     cont = cont + 1
    end
    
    mprintf("Cantidad de iteraciones: %d\n",cont);
endfunction

function x = gaussseidelRelajado(A, b, x0, w, eps)
    n = size(A,1)
    x = x0
    xant = x
    // buffer de la sumatoria
    suma = 0

    // contador de iteraciones
    cont = 0
    
    while(abs(norm(x-xant)) > eps | cont == 0) 
    xant = x
        for i = 1:n
            suma = 0
            // Sumatoria
            for j = 1:n 
                if (i<>j)
                    suma = suma + A(i,j)*x(j)
                end
            end
            // Camibo por la ecuacion teniendo en cuenta w.
            x(i) = (1 - w)*xant(i) + w/(A(i,i))*(b(i)-suma)
        end
     cont = cont + 1
    end
    
    mprintf("Cantidad de iteraciones: %d\n",cont);
endfunction


function w = calculoWIdeal(A)
    I = eye(3,3)
    Tj = (I - A*inv(diag(diag(A))))
    r = radioEspectral(Tj)
    w = 2/(1+sqrt(1-r^2))
endfunction

A = [4 3 0; 3 4 -1; 0 -1 4]
b =[24;30;-24]
x0 = [0;0;0]

//  Chequeo la convergencia del metodo

disp(metodoTest(A, tril(A)))
/*  metodoTest(A, tril(A)) = 1
    La norma está acotada por 1
    El metodo converge.
*/

disp("Metodo de Gauss-Seidel")
disp(gaussseidel(A,b,x0,0.0000001))
/*
    3.0000001
    3.9999999
    -5.
    
    Realiza 36 iteraciones.
*/

w = calculoWIdeal(A)
disp(w)
//  w = 1.2404082
disp("Metodo SOR")
disp(gaussseidelRelajado(A,b,x0,w,0.0000001))
/*
    3.
    4.
    -5.
    
    Reliza 16 iteraciones.
    
    Lo cual es notablemente menos que las que realiza el metodo son SOR
*/


/*  Ejemplos de ejecucion:

    Notese que A debe ser tridiagonal y definida positiva
*/


/*
    A = [4 3 0; 
         3 9 2;
         0 2 4]
    b =[24;30;-24]
    x0 = [0;0;0]
    
    A convergente.
    metodoTest(A, tril(A)) =

      2.8695652
      4.173913
      -8.0869565
      
    20 iteraciones.

    gaussseidel(A,b,x0,0.0000001) =

       2.8695652
       4.173913
       -8.0869565
    12 iteraciones.
*/

/*
    A = [1 0.5 0; 
         0.5 2 1;
         0 1 1]
    b =[24;30;-24]
    x0 = [0;0;0]
    
    A convergente.
    metodoTest(A, tril(A)) =

        -3.9999999
        56.
        -80
      
    44 iteraciones.

    gaussseidel(A,b,x0,0.0000001) =

         -4.
         56.
         -80.
    18 iteraciones.
*/

