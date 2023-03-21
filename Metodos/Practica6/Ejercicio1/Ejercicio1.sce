clc

clear

/*
Teorema de Gershgorin
Sea A ∈ Cn×n y sea λ un autovalor de A. Luego λ ∈ Ci para algun 
i = 1, . . . , n, donde Ci es un circulo de Gershgorin.

Este teorema nos permite acotar los autovalores.
*/

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


A = [9 0 -1 1;
     1 8 0 0;
     -2 1 7 0;
     1 1 0 1]
     
disp(spec(A))

gresGrafico(A')
/*
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

function cotas=cotasGersFilaColumna(A)
    cotas1 = cotasGers(A)
    cotas2 = cotasGers(A')
    // Se encuentran la cota menor para cada una.
    cotas(1) = max(cotas1(1),cotas2(1))
    cotas(2) = min(cotas1(2),cotas2(2))
    cotas(3) = max(cotas1(3),cotas2(3))
    cotas(4) = min(cotas1(4),cotas2(4))
endfunction


// Ejemplo 1

disp("Ejemplo 1")

A = [2 2;
     -3 1]
// Imagen 1
gresGrafico(A)
h1 = legend(['Imagen 1'])

figure

// Imagen 2
A = [2 2;
     -3 1]

gresGrafico(A')
h1 = legend(['Imagen 2'])

// Veamos como trabaja la funcion
disp(cotasGersFilaColumna(A))

/*
Cotas =
parte real:
  min = -1.
  max = 4.
parte compleja:
  min = -3.
  max = 3.
*/

// Ejemplo 2

disp("Ejemplo 2")
A = [2 2 1 1;
    -3 -1 -1 0;
     0 2 1 3;
     1 -1 -1 -2]
     
disp(cotasGers(A)')
/* cotas = 
  -5.   
   6.  
  -5.  
   5.
*/

// comparemos con cotasGersFilaColumna

disp(cotasGersFilaColumna(A))

/* cotas = 
  -5.
   6.
  -5.
   5.
   
   En este caso no logramos acotar aun mas los autovalores.
*/

disp("Ejemplo 3")
A = [2 0 1;
    -8 6 1;
     1 2 5]
     
disp(cotasGers(A)')
/* cotas = 
  -3.   
   15.  
  -9.
   9.
*/

// comparemos con cotasGersFilaColumna

disp(cotasGersFilaColumna(A))

/* cotas = 
  -3.
   11.
  -9.
   9.
   
   En este caso logramos acotar aun mas los autovalores.
*/


disp("Apartados. a)")
A = [1 0 0;
    -1 0 1;
    -1 -1 2]

disp(cotasGersFilaColumna(A))

disp(spec(A))

/*

minx  -1.
maxx   3.
miny  -2.
maxy   2.

autovalores con spec

   1.  
   1.  
   1.  

*/

disp("b)")
A = [1 0 0;
    -0.1 0 0.1;
    -0.1 -0.1 2]

disp(cotasGersFilaColumna(A))

disp(spec(A))

/*

minx  -0.1
maxx   2.1
miny  -0.2
maxy   0.2

autovalores con spec

   1.9949874  
   0.0050126  
   1.

*/

disp("c)")
A = [1 0 0;
    -0.25 0 0.25;
    -0.25 -0.25 2]
    
disp(cotasGersFilaColumna(A))

disp(spec(A))

/*

minx  -0.25
maxx   2.25
miny  -0.5
maxy   0.5

autovalores con spec

   1.9682458  
   0.0317542  
   1.  

*/

disp("d)")
A = [4 -1 0;
    -1 4 -1;
    -1 -1 4]
    
disp(cotasGersFilaColumna(A))

disp(spec(A))

/*

minx   2.
maxx   6.
miny  -2.
maxy   2.

autovalores con spec

   4.618034  
   2.381966  
   5.  

*/

// En estos dos casos, no es necesario hacer el chequeo de las filas y 
// columnas pues son matrices simetricas.

disp("e)")
A = [3 2 1;
     2 3 0;
     1 0 3]
    
disp(cotasGersFilaColumna(A))

disp(spec(A))

/*

minx   0.
maxx   6.
miny  -3.
maxy   3.
*/

disp(cotasGers(A)')
/*
   0.   6.  -3.   3.
   que es lo mismo que se obtuvo de cotasGersFilaColumna
*/
/*
autovalores con spec

   0.763932
   3.
   5.236068

*/

disp("f)")
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
disp(cotasGers(A)')
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
