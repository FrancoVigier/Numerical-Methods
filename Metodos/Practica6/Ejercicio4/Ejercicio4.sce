clc

clear

// Ejercicio 4

function circ(r,x,y)
    xarc(x-r,y+r,2*r,2*r,0,360*64)
endfunction

function CircGersValor(A)
    [n,m] = size(A)
    if n<>m
        disp("Matriz no cuadrada")
        return
    end
    
    // Se calculan los centros.
    centros = diag(A)
    // Se calculan los radios con la formula
    radios = sum(abs(A),'c') - abs(centros)
    
    // Se calculan los limites para que se grafique la zona necesaria.
    minx = round(min(centros-radios)-1)
    miny = round(min(-radios)-1)
    
    maxx = round(max(centros+radios)+1)
    maxy = round(max(radios)+1)
    
    rectangulo = [minx miny maxx maxy]
    
    // autovalores verdaderos
    plot2d(real(spec(A)), imag(spec(A)), -4,"031","", rectangulo)
    replot(rectangulo)
    // Grilla
    xgrid();
    
    // Se dibujan los circulos
    for i=1:n
        circ(radios(i), centros(i),0)
    end
    // color de los circulos.
    gca().children(1:n).foreground = color("blue");


endfunction

// Ejemplos:

A = [1 3 4;
     7 15 9;
     11 17 33]
CircGersValor(A)
h1 = legend(['Imagen 1'])

A = [2 0 1;
    -8 6 1;
     1 2 5]
figure
CircGersValor(A)

h1 = legend(['Imagen 2'])

A = [1 0 0;
    -1 0 1;
    -1 -1 2]
figure
CircGersValor(A)

h1 = legend(['Imagen 3'])


A = [1 0 0;
    -0.1 0 0.1;
    -0.1 -0.1 2]
figure
CircGersValor(A')

h1 = legend(['Imagen 4'])
A = [1 0 0;
    -0.25 0 0.25;
    -0.25 -0.25 2]
figure
CircGersValor(A')
h1 = legend(['Imagen 5'])

A = [4 -1 0;
    -1 4 -1;
    -1 -1 4]
figure
CircGersValor(A)
h1 = legend(['Imagen 6'])

