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

//Cargo los valores de los puntos
x0 = [0.2 0.3 0.9 1.3 1.6]
y0 = [0.050446 0.098426 0.7266 1.5694 2.5015]

//Como el ejercicio pide conseguir un polinomio interpolante solamete, como son 5 puntos
//armo el polinomio de grado 4
newtonGradoCuatro = InterpolacionNewton(x0,y0)

disp(newtonGradoCuatro)
//Ploteo
rango = [0:0.01:2]
plot(rango, horner(newtonGradoCuatro, rango),"r")
a=gca();a.x_location = "origin";a.y_location = "origin"
h1 = legend(['newtonGradoCuatro'])
/*SALIDA
-0.0063377 +0.1616417x 
   +0.586095x² +0.1183864x³ 
   +0.0402675x⁴

*/
