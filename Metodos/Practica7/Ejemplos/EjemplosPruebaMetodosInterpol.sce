clc

clear

// Archivo de prueba de los metodos, en el cual se ejecutan ejemplos de 
// cada metodo.

// Metodo de Lagrange

function y = Lk(x, k)
    [Xn,Xm] = size(x)
    
    // Se genera un vector con las raices del polinomio Lk
    r = [x(1:k-1) x(k+1:Xm)]
    // Con poly generamos el polinomio cuyas raices son r
    p = poly(r,"x","roots")
    // Evaluamos
    pk = horner(p, x(k))
    y = p / pk
endfunction

function z = interpolLagrange(x,y)
    [Xn,Xm] = size(x)
    pol = 0
    // Conformamos el polinomio de lagrange.
    for k = 1:Xm
        pol = pol + (Lk(x,k)*y(k))
    end
    z = pol
endfunction


// Ejemplo 1

disp("Ejemplo 1")
disp("f(x) = 5x + 6")
function y=f(x)
    y = 5.*x + 6
endfunction

xc = [0,1,2,3]
yc = [f(xc)]

// Calculando polinomios

lagrangeCubico = interpolLagrange(xc,yc)

// Mostrando resultados

disp("Valor real")
disp(f(1.3))
// f(1.3) = 12.5

disp("Lagrange")

// Cubico
disp("Resultado de evaluar polinomio cubico en 1.3")
disp(horner(lagrangeCubico,1.3))
// = 12.5

disp("Error del polinomio cubico")
disp(abs(f(1.3)-horner(lagrangeCubico,1.3)))
// = 0.

// Graficas
rango = [-0.5:0.01:3.5]
plot(rango, horner(lagrangeCubico, rango),"g")
plot(rango, f(rango))
a=gca();a.x_location = "origin";a.y_location = "origin"
h1 = legend(['lagrangeCubico','f(x)'])
figure

// Vemos como en este caso el polinomio es exacto, demostrado ejercicio 2.

// Ejemplo 2

disp("Ejemplo 2")
disp("f(x) = sin(x)")
function y=f(x)
    y = sin(x)
endfunction

xc = [0,0.5,%pi/2,%pi]
yc = [f(xc)]

// Calculando polinomios

lagrangeCubico = interpolLagrange(xc,yc)

// Mostrando resultados

disp("Valor real")
disp(f(1.3))
// f(1.3) = 0.9635582

disp("Lagrange")

// Cubico
disp("Resultado de evaluar polinomio cubico en 1.3")
disp(horner(lagrangeCubico,1.3))
// 0.9446685

disp("Error del polinomio cubico")
disp(abs(f(1.3)-horner(lagrangeCubico,1.3)))
// 0.0188897

xc = [0,0.1,0.2,0.5,%pi/3,%pi/2,%pi]
yc = [f(xc)]

lagrangeQ = interpolLagrange(xc,yc)
// Cubico
disp("Resultado de evaluar polinomio quintuple en 1.3")
disp(horner(lagrangeQ,1.3))
//   0.9635764
disp("Error del polinomio quintuple")
disp(abs(f(1.3)-horner(lagrangeQ,1.3)))
//   0.0000182
// Graficas
rango = [-0.5:0.01:3.5]
plot(rango, horner(lagrangeCubico, rango),"g")
plot(rango, horner(lagrangeQ, rango),"r")
plot(rango, f(rango))
a=gca();a.x_location = "origin";a.y_location = "origin"
h1 = legend(['lagrangeCubico','lagrangeQ','f(x)'])
figure
// Calaremente se observa como el polinomio de mayor grado aproxima mejor
// el valor pedido.

// Ejemplo 3


disp("Ejemplo 3")
disp("f(x) = sen(x)/x")
function y=f(x)
    y = sin(x)./x
endfunction

xc = [6,6.5,7,7.5]
yc = [f(xc)]

// Calculando polinomios

lagrange4 = interpolLagrange(xc,yc)

// Mostrando resultados

disp("Valor real")
disp(f(6.75))
// 0.0666732

disp("Lagrange")

// Cubico
disp("Resultado de evaluar polinomio 4 en 6.75")
disp(horner(lagrange4,6.75))
// 0.0665036

disp("Error del polinomio 4")
disp(abs(f(6.75)-horner(lagrange4,6.75)))
// 0.0001696

// Graficas
rango = [5.5:0.01:8]
plot(rango, horner(lagrange4, rango),"g")
plot(rango, f(rango))
a=gca();a.x_location = "origin";a.y_location = "origin"
h1 = legend(['lagrange4','f(x)'])
figure
clc

clear

// Newton

function dif = diferenciaDivididas(x, y, i, k)
    // Calculamos las diferencias divididas de forma recursiva,
    // al usarla hay que verivicar que k sea siempre distinto de 0,
    // lo cual no tiene sentido en la definicion de diferencias divididas.
    if k - i == 1 then
        dif = (y(k) - y(i)) / (x(k) - x(i))
    else 
        // Calculamos segun la formula del apunte (pag. 5)
        dif = (diferenciaDivididas(x, y, i+1, k) - diferenciaDivididas(x, y, i, k-1)) / (x(k) - x(i))
    end
endfunction

function p = InterpolacionNewton(x0, y0)
    // Obtenemos y guardamos el tamaño
    [Xn, Xm] = size(x0)
    // calculamos el primer coeficiente
    p = y0(1)
    for i=1:Xm-1
        // formula del polinomio de newton.
        p = p + poly(x0(1:i),"x","roots") * diferenciaDivididas(x0, y0, 1, i+1)
    end

endfunction


// Ejemplo 1

disp("Ejemplo 1")
disp("f(x) = 5x + 6")
function y=f(x)
    y = 5.*x + 6
endfunction

xc = [0,1,2,3]
yc = [f(xc)]

// Calculando polinomios

newtonCubico = InterpolacionNewton(xc,yc)

// Mostrando resultados

disp("Valor real")
disp(f(1.3))
// f(1.3) = 12.5

disp("Newton")

// Cubico
disp("Resultado de evaluar polinomio cubico en 1.3")
disp(horner(newtonCubico,1.3))
// = 12.5

disp("Error del polinomio cubico")
disp(abs(f(1.3)-horner(newtonCubico,1.3)))
// = 0.

// Graficas
rango = [-0.5:0.01:3.5]
plot(rango, horner(newtonCubico, rango),"g")
plot(rango, f(rango))
a=gca();a.x_location = "origin";a.y_location = "origin"
h1 = legend(['newtonCubico','f(x)'])
figure

// Vemos como en este caso el polinomio es exacto, demostrado ejercicio 2.

// Ejemplo 2

disp("Ejemplo 2")
disp("f(x) = sin(x)")
function y=f(x)
    y = sin(x)
endfunction

xc = [0,0.5,%pi/2,%pi]
yc = [f(xc)]

// Calculando polinomios

newtonCubico = InterpolacionNewton(xc,yc)

// Mostrando resultados

disp("Valor real")
disp(f(1.3))
// f(1.3) = 0.9635582

disp("Lagrange")

// Cubico
disp("Resultado de evaluar polinomio cubico en 1.3")
disp(horner(newtonCubico,1.3))
// 0.9446685

disp("Error del polinomio cubico")
disp(abs(f(1.3)-horner(newtonCubico,1.3)))
// 0.0188897

xc = [0,0.1,0.2,0.5,%pi/3,%pi/2,%pi]
yc = [f(xc)]

newtonQ = InterpolacionNewton(xc,yc)
// Cubico
disp("Resultado de evaluar polinomio quintuple en 1.3")
disp(horner(newtonQ,1.3))
//   0.9635764
disp("Error del polinomio quintuple")
disp(abs(f(1.3)-horner(newtonQ,1.3)))
//   0.0000182
// Graficas
rango = [-0.5:0.01:3.5]
plot(rango, horner(newtonCubico, rango),"g")
plot(rango, horner(newtonQ, rango),"r")
plot(rango, f(rango))
a=gca();a.x_location = "origin";a.y_location = "origin"
h1 = legend(['newtonCubico','newtonQ','f(x)'])
figure
// Calaremente se observa como el polinomio de mayor grado aproxima mejor
// el valor pedido.

// Ejemplo 3


disp("Ejemplo 3")
disp("f(x) = sen(x)/x")
function y=f(x)
    y = sin(x)./x
endfunction

xc = [6,6.5,7,7.5]
yc = [f(xc)]

// Calculando polinomios

newton4 = InterpolacionNewton(xc,yc)

// Mostrando resultados

disp("Valor real")
disp(f(6.75))
// 0.0666732

disp("Lagrange")

// Cubico
disp("Resultado de evaluar polinomio 4 en 6.75")
disp(horner(newton4,6.75))
// 0.0665036

disp("Error del polinomio 4")
disp(abs(f(6.75)-horner(newton4,6.75)))
// 0.0001696

// Graficas
rango = [5.5:0.01:8]
plot(rango, horner(newton4, rango),"g")
plot(rango, f(rango))
a=gca();a.x_location = "origin";a.y_location = "origin"
h1 = legend(['newton4','f(x)'])

