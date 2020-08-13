function varargout = fourier_series(varargin)
% fourier_series MATLAB code for fourier_series.fig
%      fourier_series, by itself, creates a new fourier_series or raises the existing
%      singleton*.
%
%      H = fourier_series returns the handle to a new fourier_series or the handle to
%      the existing singleton*.
%
%      fourier_series('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in fourier_series.M with the given input arguments.
%
%      fourier_series('Property','Value',...) creates a new fourier_series or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fourier_series_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fourier_series_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @fourier_series_OpeningFcn, ...
    'gui_OutputFcn',  @fourier_series_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Se ejecuta justo antes de que fourier_series se haga visible.
function fourier_series_OpeningFcn(hObject, eventdata, handles, varargin)
set(handles.edit3,'visible','off');
set(handles.text12,'visible','off');
% componentes para el trazado manual
set(handles.draw_axes,'visible','off');
set(handles.button_draw_reset,'visible','off');
set(handles.button_draw_ok,'visible','off');
set(handles.button_minus,'visible','off');
set(handles.text_num_circles,'visible','off');
set(handles.button_add,'visible','off');


% t = 0:0.0001:0.5;
% y = square(2*pi*5*t);
% axes(handles.axes1)
% plot(t,y)
% grid on
% axis([0 0.5 -1.5 1.5])

% x = t;
% y = zeros(size(x));%
% for k=1:1
%     for i=1:length(x)
%         y(i) = y(i)+(2/pi)*(1-(-1)^k)*sin(2*pi*5*k*x(i))/k;
%     end
% end%
% axes(handles.axes2);
% axis([0 0.5 -2 2]);
% plot(x,y);
% grid on

% Choose default command line output for fourier_series
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes fourier_series wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% Inicializa la opcion de trazar a mano
set_up_the_drawing(handles);


% --- Executes during object creation, after setting all properties.
function lineEdit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function functionEdit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Outputs from this function are returned to the command line.
function varargout = fourier_series_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


%%
% --- Executes on selection change in functionEdit.
function functionEdit_Callback(hObject, eventdata, handles)
index = handles.functionEdit.Value;
% si se selecciona el index 4 es decir: Onda personalizada se activaran los
% componetes indicados a continuacion
if index == 4
    set(handles.edit3,'visible','on');
    set(handles.text12,'visible','on');
    set(handles.axes1,'visible','on');
    set(handles.draw_axes,'visible','off');
elseif index == 5
    cla(handles.axes1);
    set(handles.edit3,'visible','off');
    set(handles.text12,'visible','off');
    set(handles.axes1,'visible','off');
    set(handles.draw_axes,'visible','on');
    set(handles.button_draw_reset,'visible','on');
    set(handles.button_draw_ok,'visible','on');
    set(handles.button_minus,'visible','on');
    set(handles.text_num_circles,'visible','on');
    set(handles.button_add,'visible','on');
else
    set(handles.edit3,'visible','off');
    set(handles.text12,'visible','off');
    set(handles.draw_axes,'visible','off');
    set(handles.button_draw_reset,'visible','off');
    set(handles.button_draw_ok,'visible','off');
    set(handles.button_minus,'visible','off');
    set(handles.text_num_circles,'visible','off');
    set(handles.button_add,'visible','off');
    set(handles.axes1,'visible','on');
end


% --- Esta función se  ejecuta al presionar el boton calcular.
function updateButton_Callback(hObject, eventdata, handles)
allItems = handles.functionEdit.String;
index = handles.functionEdit.Value;
func = allItems{index};
txt_n = get(handles.lineEdit,'String');

n = str2num(txt_n);
L = 0.5; % L es horizontal
% L indica los limites del intervalo, por ejemplo de -pi hasta pi, ó -1
% hasta 1 siendo respectivamente L: pi y 1
% a0, an, bn son coeficientes
h =  0.0001; % incremento o salto horizontalmente
% k ó n indica cuantos terminos de la serie fourier vamos a graficar
switch index
    case 1
        %% Gráfico estático de la onda cuadrada
        t = 0:h:L; % 0, 0.0001, 0.0002,..., 0.5
        y = square(2*pi*5*t);%  1, 1.., -1, -1.., 1, 1
        % Seleccione el eje sobre el que desea trazar.
        axes(handles.axes1)
        plot(t,y) %plot(X, Y) grafica lineas 2D
        axis([0 0.5 -1.5 1.5])
        grid on
        
        % Diagrama de la aproximación de las series de Fourier.
        % Gráfico dinamico de la onda cuadrada
        x = 0:h:L;
        y = zeros(size(x));
        for k=1:n(1)
            for i=1:length(x)
                % Realizamos las sumatorias correspondientes
                y(i) = y(i) + (2/pi)*(1-(-1)^k)*sin(2*pi*5*k*x(i))/k;
                %y(i) = y(i) +  (4/pi) * (1/k) * sin(2*pi*5*k*t(i));
            end
        end
        
        axes(handles.axes2);
        axis([0 0.5 -1.5 1.5]);
        plot(x, y);
        grid on
        axis([0 0.5 -1.5 1.5]);
        
    case 2
        %% GRAFICO ESTÁTICO DE LA ONDA DE DIENTES DE SIERRA
        t = 0:h:L; % 0, 0.0001, 0.0002,..., 0.5
        y = sawtooth(2*pi*5*t);
        % Seleccione el eje sobre el que desea trazar.
        axes(handles.axes1);
        plot(t,y)
        grid on
        axis([0 0.5 -1.5 1.5])
        
        % GRAFICO DINAMICO DE LA ONDA DE DIENTES DE SIERRA
        % Diagrama de la aproximación de las series de Fourier.
        y = zeros(size(t));
        % FIXME
        for k=1:n(1)
            for i=1:length(t)
                y(i) = y(i) - (1/(k*pi)) * sin(2*pi*5*k*t(i));
            end
        end
        y(i) = y(i) + 1/2;
        axes(handles.axes2);
        plot(t,y)
        grid on
        axis([0 0.5 -1.5 1.5])
        
        
    case 3
        %% Gráfico estático de la onda triangular
        t = 0:h:L; % 0, 0.0001, 0.0002,..., 0.5
        y = sawtooth(2*pi*5*t, 1/2); % 1/2 convierte en triangular al dividir
        % Seleccione el eje sobre el que desea trazar.
        axes(handles.axes1);
        plot(t,y)
        grid on
        axis([0 0.5 -1.5 1.5])
        
        % Gráfico dinamico de la onda triangular
        % Diagrama de la aproximación de las series de Fourier.
        y = zeros(size(t));
        
        for k=1:n(1)
            for i=1:length(t)
                y(i) = y(i) + 8 * ((-1)^((k-1)/2))/(pi^2*k^2) * sin(2*pi*5*k*t(i));
            end
        end
        
        axes(handles.axes2);
        plot(t,y)
        grid on
        axis([0 0.5 -1.5 1.5])
        
        
    case 4
        %% TODO: Gráfico de una onda personalizada
        myedit3 = get(handles.edit3,'String');
        if myedit3 == ""
            msg = msgbox('Ingrese una función', 'Empty Value', 'error');
            th = findall(msg, 'Type', 'Text');    %get handle to text within msgbox
            th.FontSize = 12;
        else
            syms x s
            fun = get(handles.edit3, 'string');% obtiene la función desde la GUI
            fun = str2sym(fun);
            % fun = abs(x);
            % fun = cos(2*x) - 2;
            per = 2; % perido de la funcion
            lmin = 0; % inicio de la funcion
            A0 =((2/per)*int((fun*cos(2*pi*0*1/per)), x, lmin, per+lmin)) / 2;
            s = A0;
            
            for i=1:n
                An = (2/per)*int((fun*cos(2*pi*i*x/per)),x,lmin,per+lmin);
                Bn = (2/per)*int((fun*sin(2*pi*i*x/per)),x,lmin,per+lmin);
                as = An * cos(2*pi*i*x/per);
                bs = Bn * sin(2*pi*i*x/per);
                s = s + as + bs;
            end
            
            axes(handles.axes2);
            fplot(s,[lmin, 4*per + lmin]);
            grid on
            
        end %
        
    otherwise
end


% --- Se ejecuta cuando se presiona el boton Ejecutar.
function button_draw_ok_Callback(hObject, eventdata, handles)
global xy;
if ~isempty(xy)
    n = str2num(get(handles.text_num_circles,'String'));
    fourier_epicycles(xy(:,1), xy(:,2), n);
end

% --- Se ejecuta cuando se presiona el boton Limpiar.
function button_draw_reset_Callback(hObject, eventdata, handles)
global xy;
cla(handles.draw_axes);
xy = [];
set_up_the_drawing(handles);

% --- Executes on button press in button_minus.
function button_minus_Callback(hObject, eventdata, handles)
value = str2num(get(handles.text_num_circles,'String'))-1;
if value > 1
    set(handles.text_num_circles,'String', num2str(value));
end


% --- Executes on button press in button_add.
function button_add_Callback(hObject, eventdata, handles)
global xy;
value = str2num(get(handles.text_num_circles,'String'))+1;
if value <= size(xy,1)
    set(handles.text_num_circles,'String', num2str(value));
end

% --- Establece el espacio de dibujo
function set_up_the_drawing(handles)
% Coordenadas del futuro dibujo
global xy;
xy = [];
try
    % Funcionalidad de dibujo
    title(handles.draw_axes,'Dibuja una figura');
    hFH = imfreehand();
    if isempty(hFH)        
        return; % Saltar...
    end
    xy = hFH.getPosition;
    xy = [xy; xy(1,:)];
    delete(hFH);
    xCoordinates = xy(:, 1);
    yCoordinates = xy(:, 2);
    plot(xCoordinates, yCoordinates, 'r', 'LineWidth', 2);
    hold off;
    
    % Establece el número de círculos por defecto.
    set(handles.text_num_circles,'String', size(xy,1));
catch me
end
