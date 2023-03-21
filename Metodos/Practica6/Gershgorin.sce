/*
Teorema de Gershgorin
Sea A ∈ Cn×n y sea λ un autovalor de A. Luego λ ∈ Ci para algun 
i = 1, . . . , n, donde Ci es un circulo de Gershgorin.

Este teorema nos permite acotar los autovalores.
*/


//Cotas de Gershgorin en un vector con cota real e imaginaria, 
//acota todos los autovalores en un unico vector
function cotas = cotasGers(A)
    // Los centros son los elementos de la diagonal.
    centros = diag(A)
    // Se calculan los radios segun la formula de los circulos.
    radios = sum(abs(A),'c') - abs(centros)
    
    // Se calculan los extremos.
    minx = min(centros-radios)
    miny = min(-radios)
    
    maxx = max(centros+radios)
    maxy = max(radios)
    
    cotas = [minx maxx miny maxy]
    
endfunction

//Cotas de Gershgorin, por medio de la acotacion de una matriz y su traspuesta, también en un vector
//USAR SI LA MATRIZ NO ES SIMETRICA
function cotas=cotasGersFilaColumna(A)
    cotas1 = cotasGers(A)
    cotas2 = cotasGers(A')
    // Se encuentran la cota menor para cada una.
    cotas(1) = max(cotas1(1),cotas2(1))
    cotas(2) = min(cotas1(2),cotas2(2))
    cotas(3) = max(cotas1(3),cotas2(3))
    cotas(4) = min(cotas1(4),cotas2(4))
endfunction

//Gershgorin Grafico
function circ(r,x,y)
    xarc(x-r,y+r,2*r,2*r,0,360*64)
endfunction

function gresGrafico(A)
    [n,m] = size(A)
    if n<>m
        disp("Matriz no cuadrada")
        return
    end
    
    centros = diag(A)
    radios = sum(abs(A),'c') - abs(centros)
    
    minx = round(min(centros-radios)-1)
    miny = round(min(-radios)-1)
    
    maxx = round(max(centros+radios)+1)
    maxy = round(max(radios)+1)
    
    // replot (minx miny maxx maxy)
    rectangulo = [minx miny maxx maxy]
    
    // autovalores verdaderos
    plot2d(real(spec(A)), imag(spec(A)), -4,"031","", rectangulo)
    
    replot(rectangulo)
    xgrid();
    
    // circulos de gres
    for i=1:n
        circ(radios(i), centros(i),0)
    end
    
    // color de los circulos.
    gca().children(1:n).foreground = color("blue");

endfunction

//gershgorin(A). Muestra LAS FORMULAS DE LOS CIRCULOS DE GERSHGORIN. USA corolario 1 para acotar más con su traspuesta

function gershgorin(A)
    sz = size(A, 1);
    
    for i = 1:sz
        suma = 0;
        sumaCol = 0;
        for j = 1:sz
//Calculo los radios de los circulos de Gershgorin
            if (i <> j)
                suma = suma + abs(A(i,j));
                sumaCol = sumaCol + abs(A(j,i))
            end;
        end;
//Conformo el circulo de Gershgorin, |z - a ii|
            mprintf("|lambda - %f| <= %f\n", A(i,i),min( suma,sumaCol));
    end;
endfunction

//Comando de scilab para ver los autovalores de A


disp("EJEMPLO DE USO")
A = [4.75 2.25 -0.25
     2.25 4.75 1.25
    -0.25 1.25 4.75]
    
disp(cotasGersFilaColumna(A))

disp(spec(A))

/*

minx   1.25
maxx   8.25
miny  -3.5
maxy   3.5

*/
disp(cotasGers(A))
/*
   1.25   8.25  -3.5   3.5
   que es lo mismo que se obtuvo de cotasGersFilaColumna
*/

/*

autovalores con spec

   2.0646374
   4.9616991
   7.2236635

*/
//gresGrafico(A)
//h1 = legend(['Autovalores'])
//figure //El figure VA SI QUERES HACER MAS DE 1 GRESGRAFICO

B = [4 -1 0
    -1  4 1
    -1 -1 4]
gershgorin(B)
gresGrafico(B)
h2 = legend(['Autovalores'])
//figure
