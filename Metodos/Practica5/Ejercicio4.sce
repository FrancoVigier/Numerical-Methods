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
    suma = 0

    cont = 0
    
    while(abs(norm(x-xant)) > eps | cont == 0)
    xant = x
        for i = 1:n
            suma = 0
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
            if abs(a(i,k))>amax then // se encuentra el mayor elemento debajo del pivote
                kpivot = i; // si se enecuetra se guarda la fila
                amax = abs(a(i,k)); // y se actualiza el mayor acutal
            end;
        end;
        // Se realiza el intercambio de filas.
        temp = a(kpivot,:);
        a(kpivot,:) = a(k,:);
        a(k,:) = temp;
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

N = 500
A = 8*eye(N,N) + 2*diag(ones(N-1,1),1)+2*diag(ones(N-1,1),-1) + diag(ones(N-3,1),3) + diag(ones(N-3,1),-3)
b = ones(N,1)
x0 = zeros(N,1)

disp("Chequeo de convergencia")
disp(metodoTest(A, tril(A)))

/*
    metodoTest(A, tril(A)) = 1
    Matriz diagonal dominante
    
    Sabemos que el metodo de Gauss-Seidel convergerá.
*/


disp("Eliminacion con pivoteo 500")
tic(); gausselimPP(A, b); t=toc()
disp(t)

disp("Gauss-Seidel 500 a la -6")
tic();gaussseidel(A, b, x0, 0.000001); t=toc()
disp(t)

disp("Gauss-Seidel 500 a la -12")
tic();gaussseidel(A, b, x0, 0.000000000001); t=toc()
disp(t)

N = 1000
A = 8*eye(N,N) + 2*diag(ones(N-1,1),1)+2*diag(ones(N-1,1),-1) + diag(ones(N-3,1),3) + diag(ones(N-3,1),-3)
b = ones(N,1)
x0 = zeros(N,1)

disp("Eliminacion con pivoteo 1000")
tic(); gausselimPP(A, b); t=toc()
disp(t)

disp("Gauss-Seidel 1000 a la -6")
tic();gaussseidel(A, b, x0, 0.000001); t=toc()
disp(t)

disp("Gauss-Seidel 1000 a la -12")
tic();gaussseidel(A, b, x0, 0.000000000001); t=toc()
disp(t)

/*
 Medidas en segundos.
 
 Eliminacion con pivoteo 500

   254.19679

 Gauss-Seidel 500 a la -6
Cantidad de iteraciones: 18

   17.912428

 Gauss-Seidel 500 a la -12
Cantidad de iteraciones: 45

   44.811087

 Eliminacion con pivoteo 1000

   1998.3351

 Gauss-Seidel 1000 a la -6
Cantidad de iteraciones: 18

   62.570889

 Gauss-Seidel 1000 a la -12
Cantidad de iteraciones: 45

   153.20281

    
    Claramente el metodo de Gauss-Seidel es mas eficiente que la elimina
    cion Gaussiana. Corri los metodos varias veces, y note que el tiempo
    que tomaba variaba de ejecicion en ejecucion, por lo tanto promedié
    los resultados.
*/
