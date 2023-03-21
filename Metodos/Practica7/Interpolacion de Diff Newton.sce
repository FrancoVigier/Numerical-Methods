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

xl = [0.2,0.4]
yl = [1.2214,1.4918]

xc = [0,0.2,0.4,0.6]
yc = [1.0,1.2214,1.4918,1.8221]

newtonLineal = InterpolacionNewton(xl,yl)
newtonCubica = InterpolacionNewton(xc,yc)

disp("Newton")


// Lienal

disp("Resultado de evaluar polinomio lienal en 1/3")
disp(horner(newtonLineal,1/3))
// = 1.4016667
disp("Cota de error lineal:")
disp(abs((1/3-0.2)*(1/3-0.4)*1/2*%e^(0.6)))
// = 0.0080983
disp("Error del polinomio lineal")
disp(abs(1.395612425-horner(newtonLineal,1/3)))
// = 0.0060542

// Cubico

disp("Resultado de evaluar polinomio cubico en 1/3")
disp(horner(newtonCubica,1/3))
// = 1.3955494
disp("Cota de error cubico:")
disp((1/3-0)*(1/3-0.2)*(1/3-0.4)*(1/3-0.6)*1/factorial(4)*%e^0.6)
// = 0.00006
disp("Error del polinomio cubico")
disp(abs(1.395612425-horner(newtonCubica,1/3)))
// = 0.000063

rango = [-2:0.01:2]
plot(rango, horner(newtonLineal, rango),"r")
plot(rango, horner(newtonCubica, rango),"g")
plot(rango, exp(rango))
a=gca();a.x_location = "origin";a.y_location = "origin"
h1 = legend(['newtonLineal','newtonCubica','e^x'])

