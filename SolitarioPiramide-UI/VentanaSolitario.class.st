"
Interfaz gráfica Morphic para el Solitario de Pirámide en Pharo 12.
Se comunica exclusivamente mediante la API pública de SolitarioPiramide-Modelo sin contener lógica de reglas.
Muestra la pirámide de 7 filas, la reserva, la carta visible del pozo, el puntaje, el tiempo restante,
el récord, los botones de Nueva partida y Deshacer, y una barra de estado para mensajes y errores controlados.
"
Class {
	#name : 'VentanaSolitario',
	#superclass : 'BorderedMorph',
	#instVars : [
		'juego',
		'registroDeRecords',
		'seleccionActual',
		'mensajeEstado',
		'labelPuntaje',
		'labelTiempo',
		'labelRecord',
		'labelEstado',
		'contenedorTablero'
	],
	#category : 'SolitarioPiramide-UI',
	#package : 'SolitarioPiramide-UI'
}

{ #category : 'instance creation' }
VentanaSolitario class >> abrir [
	| ventana |
	ventana := self new.
	ventana openInWindowLabeled: 'Solitario de Pirámide'.
	ventana startStepping.
	^ ventana
]

{ #category : 'private' }
VentanaSolitario >> actualizarEtiquetas [
	labelPuntaje contents: 'Puntaje: ' , juego puntaje asString.
	labelTiempo contents: 'Tiempo: ' , juego tiempoRestante asString , ' s'.
	labelRecord contents: 'Récord: ' , juego mejorPuntaje asString.
	labelEstado contents: mensajeEstado
]

{ #category : 'private' }
VentanaSolitario >> actualizarInterfazConMensaje: unMensaje [
	mensajeEstado := unMensaje.
	self actualizarEtiquetas.
	self redibujarTablero
]

{ #category : 'private' }
VentanaSolitario >> actualizarMensajeFinDePartida [
	mensajeEstado := juego estado descripcion , ' - Puntaje final: ' , juego puntaje asString.
	self actualizarEtiquetas.
	self redibujarTablero
]

{ #category : 'private' }
VentanaSolitario >> construirBarraSuperior [
	| botonNueva botonDeshacer |
	labelPuntaje := StringMorph contents: 'Puntaje: 0'.
	labelPuntaje color: Color white.
	labelPuntaje position: self position + (20 @ 18).
	self addMorph: labelPuntaje.

	labelTiempo := StringMorph contents: 'Tiempo: 300 s'.
	labelTiempo color: Color white.
	labelTiempo position: self position + (165 @ 18).
	self addMorph: labelTiempo.

	labelRecord := StringMorph contents: 'Récord: 0'.
	labelRecord color: Color yellow.
	labelRecord position: self position + (320 @ 18).
	self addMorph: labelRecord.

	botonNueva := SimpleButtonMorph new
		label: 'Nueva partida';
		target: self;
		actionSelector: #nuevaPartida;
		position: self position + (500 @ 14);
		yourself.
	self addMorph: botonNueva.

	botonDeshacer := SimpleButtonMorph new
		label: 'Deshacer';
		target: self;
		actionSelector: #deshacerMovimiento;
		position: self position + (625 @ 14);
		yourself.
	self addMorph: botonDeshacer
]

{ #category : 'private' }
VentanaSolitario >> construirContenedores [
	| barraEstado |
	contenedorTablero := Morph new.
	contenedorTablero color: Color transparent.
	contenedorTablero extent: 760 @ 505.
	contenedorTablero position: self position + (0 @ 55).
	self addMorph: contenedorTablero.

	barraEstado := BorderedMorph new.
	barraEstado color: (Color r: 0.0 g: 0.12 b: 0.25).
	barraEstado borderColor: Color lightGray.
	barraEstado borderWidth: 1.
	barraEstado extent: 720 @ 36.
	barraEstado position: self position + (20 @ 568).
	self addMorph: barraEstado.

	labelEstado := StringMorph contents: ''.
	labelEstado color: Color white.
	labelEstado position: barraEstado position + (12 @ 10).
	barraEstado addMorph: labelEstado
]

{ #category : 'private' }
VentanaSolitario >> crearMorphParaCarta: unaCarta enUbicacion: unaUbicacion [
	^ CartaMorph
		paraCarta: unaCarta
		libre: (unaUbicacion estaDisponibleEn: juego)
		seleccionada: (seleccionActual = unaUbicacion)
		accion: [ self seleccionarUbicacion: unaUbicacion ]
]

{ #category : 'actions' }
VentanaSolitario >> deshacerMovimiento [
	self
		ejecutarAccionJuego: [ juego deshacer ]
		mensajeExito: 'Movimiento deshecho.'
]

{ #category : 'private' }
VentanaSolitario >> dibujarPiramide [
	| anchoCarta espacioHorizontal |
	anchoCarta := 72.
	espacioHorizontal := 84.

	1 to: 7 do: [ :fila |
		| anchoFila xInicial y |
		anchoFila := (fila - 1) * espacioHorizontal + anchoCarta.
		xInicial := (760 - anchoFila) // 2.
		y := 10 + ((fila - 1) * 46).
		1 to: fila do: [ :posicion |
			| carta |
			carta := juego piramide cartaEnFila: fila posicion: posicion.
			carta ifNotNil: [
				| ubicacion x cartaMorph |
				ubicacion := UbicacionPiramide fila: fila posicion: posicion.
				x := xInicial + ((posicion - 1) * espacioHorizontal).
				cartaMorph := self
					crearMorphParaCarta: carta
					enUbicacion: ubicacion.
				cartaMorph position: contenedorTablero position + (x @ y).
				contenedorTablero addMorph: cartaMorph ] ] ]
]

{ #category : 'private' }
VentanaSolitario >> dibujarReservaYPozo [
	| reservaMorph pozoMorph cartaVisible accionReserva |
	accionReserva := juego pozo puedeRobar
		ifTrue: [ [ self robarDelMazo ] ]
		ifFalse: [
			juego pozo puedeReciclar
				ifTrue: [ [ self reciclarPozo ] ]
				ifFalse: [ [ self robarDelMazo ] ] ].

	reservaMorph := CartaMorph
		paraReservaConCantidad: juego pozo cantidadEnReserva
		accion: accionReserva.
	reservaMorph position: contenedorTablero position + (260 @ 400).
	contenedorTablero addMorph: reservaMorph.

	juego pozo puedeReciclar ifTrue: [
		| botonMezclar |
		botonMezclar := SimpleButtonMorph new
			label: 'Mezclar pozo';
			target: self;
			actionSelector: #reciclarPozo;
			yourself.
		botonMezclar position: contenedorTablero position + ((248 - botonMezclar width) @ 434).
		contenedorTablero addMorph: botonMezclar ].

	cartaVisible := juego cartaPozoVisible.
	cartaVisible
		ifNil: [
			pozoMorph := CartaMorph paraPozoVacio ]
		ifNotNil: [
			pozoMorph := self
				crearMorphParaCarta: cartaVisible
				enUbicacion: UbicacionPozo new ].
	pozoMorph position: contenedorTablero position + (400 @ 400).
	contenedorTablero addMorph: pozoMorph
]

{ #category : 'private' }
VentanaSolitario >> ejecutarAccionJuego: unBloque mensajeExito: unMensaje [
	[
		unBloque value.
		seleccionActual := nil.
		juego estado estaTerminada
			ifTrue: [ self actualizarMensajeFinDePartida ]
			ifFalse: [ self actualizarInterfazConMensaje: unMensaje ]
	] on: MovimientoInvalido do: [ :error |
		seleccionActual := nil.
		self actualizarInterfazConMensaje: error motivo ]
]

{ #category : 'initialization' }
VentanaSolitario >> initialize [
	super initialize.
	self extent: 760 @ 620.
	self color: (Color r: 0.0 g: 0.12 b: 0.25).
	self borderWidth: 0.
	registroDeRecords := RegistroDeRecords conArchivoPorDefecto.
	self construirBarraSuperior.
	self construirContenedores.
	self nuevaPartida
]

{ #category : 'actions' }
VentanaSolitario >> nuevaPartida [
	juego := JuegoSolitario conRegistroDeRecords: registroDeRecords.
	seleccionActual := nil.
	self actualizarInterfazConMensaje: 'Seleccioná una carta libre, un rey o robá de la reserva.'
]

{ #category : 'actions' }
VentanaSolitario >> reciclarPozo [
	self
		ejecutarAccionJuego: [ juego reciclarPozo ]
		mensajeExito: 'Pozo mezclado nuevamente en la reserva.'
]

{ #category : 'private' }
VentanaSolitario >> redibujarTablero [
	contenedorTablero removeAllMorphs.
	self dibujarPiramide.
	self dibujarReservaYPozo
]

{ #category : 'actions' }
VentanaSolitario >> robarDelMazo [
	self
		ejecutarAccionJuego: [ juego robarCarta ]
		mensajeExito: 'Carta robada de la reserva.'
]

{ #category : 'actions' }
VentanaSolitario >> seleccionarUbicacion: unaUbicacion [
	| carta |
	juego estado permiteMovimientos ifFalse: [
		self actualizarMensajeFinDePartida.
		^ self ].

	carta := unaUbicacion cartaEn: juego.
	carta ifNil: [ ^ self ].

	seleccionActual = unaUbicacion ifTrue: [
		seleccionActual := nil.
		self actualizarInterfazConMensaje: 'Selección cancelada.'.
		^ self ].

	seleccionActual ifNil: [
		carta esRey ifTrue: [
			self
				ejecutarAccionJuego: [ juego eliminarReyEn: unaUbicacion ]
				mensajeExito: 'Rey eliminado.'.
			^ self ].
		(unaUbicacion estaDisponibleEn: juego) ifFalse: [
			self actualizarInterfazConMensaje: 'La carta está cubierta y no se puede seleccionar.'.
			^ self ].
		seleccionActual := unaUbicacion.
		self actualizarInterfazConMensaje: 'Seleccionada: ' , carta printString , '. Elegí otra carta que sume 13.'.
		^ self ].

	self
		ejecutarAccionJuego: [ juego eliminarParEn: seleccionActual y: unaUbicacion ]
		mensajeExito: 'Par eliminado.'
]

{ #category : 'stepping' }
VentanaSolitario >> step [
	juego ifNil: [ ^ self ].
	juego estado permiteMovimientos ifFalse: [ ^ self ].
	juego pasarSegundos: 1.
	juego estado estaTerminada
		ifTrue: [ self actualizarMensajeFinDePartida ]
		ifFalse: [ self actualizarEtiquetas ]
]

{ #category : 'stepping' }
VentanaSolitario >> stepTime [
	^ 1000
]

{ #category : 'stepping' }
VentanaSolitario >> wantsSteps [
	^ true
]