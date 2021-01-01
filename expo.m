clc;clear; close all
pkg load image

#cargar imagenes
paisaje=imread('land.jpg'); oficina=imread('oficina.jpg');
#mostrar imagenes
subplot(1,3,1); imshow(paisaje); subplot(1,3,2); imshow(oficina);
#tamaño imagenes
[m,n,c]=size(paisaje); [m2,n2,_]=size(oficina);
#coordenadas de los vertices
incp=[ 1 1; 1 m; n m; n 1; ];
outcp=[ 1287 536; 1286 684;1593 698; 1600 516; ];
#crear matriz de transformacion
T = maketform('projective',incp,outcp);
#aplicar transformacion
[im2 xdata ydata] = imtransform (paisaje, T, 'udata', [1 n],
  'vdata', [1 m],"xdata",[1 n2],"ydata",[1 m2] );

#hacer grilla
xa=[1:n2]; ya=[1:m2]; [x,y]=meshgrid(xa,ya);
#coordenadas x,y de los vertices del poligono
xs = outcp(:,1); ys = outcp(:,2);
#indices que estan dentro del poligono
inside=inpolygon(x,y,xs,ys);

inside=repmat(inside,1,1,3); #repite para cada canal

#reemplazar indices de la imagen con los del cuadro
result=oficina; result(inside)=im2(inside);

subplot(1,3,3); imshow(result)

