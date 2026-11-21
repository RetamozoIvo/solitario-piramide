"
Representa visualmente una carta (o un casillero de reserva/pozo) en Morphic para el Solitario de Pirámide.
Dibuja el valor y palo con colores acordes (rojo para Corazones y Diamantes, negro para Tréboles y Picas),
atenúa cartas cubiertas, resalta la carta seleccionada y ejecuta un bloque de acción al hacer clic.
"
Class {
	#name : 'CartaMorph',
	#superclass : 'BorderedMorph',
	#instVars : [
		'accionAlClic'
	],
	#category : 'SolitarioPiramide-UI',
	#package : 'SolitarioPiramide-UI'
}

{ #category : 'instance creation' }
CartaMorph class >> paraCarta: unaCarta libre: estaLibre seleccionada: estaSeleccionada accion: unBloque [
	^ self new
		configurarParaCarta: unaCarta
		libre: estaLibre
		seleccionada: estaSeleccionada
		accion: unBloque
]

{ #category : 'instance creation' }
CartaMorph class >> paraPozoVacio [
	^ self new configurarPozoVacio
]

{ #category : 'instance creation' }
CartaMorph class >> paraReservaConCantidad: unaCantidad accion: unBloque [
	^ self new configurarReservaConCantidad: unaCantidad accion: unBloque
]

{ #category : 'private' }
CartaMorph >> agregarEtiqueta: unTexto color: unColor desplazamiento: unPunto [
	| etiqueta |
	etiqueta := StringMorph contents: unTexto.
	etiqueta color: unColor.
	etiqueta position: self position + unPunto.
	self addMorph: etiqueta
]

{ #category : 'private' }
CartaMorph >> colorTextoParaCarta: unaCarta libre: estaLibre [
	| esRoja |
	esRoja := #('Corazones' 'Diamantes') includes: unaCarta palo.
	estaLibre ifTrue: [
		^ esRoja
			ifTrue: [ Color r: 0.8 g: 0.1 b: 0.1 ]
			ifFalse: [ Color black ] ].
	^ esRoja
		ifTrue: [ Color r: 0.55 g: 0.35 b: 0.35 ]
		ifFalse: [ Color darkGray ]
]

{ #category : 'initialization' }
CartaMorph >> configurarParaCarta: unaCarta libre: estaLibre seleccionada: estaSeleccionada accion: unBloque [
	| colorTexto textoPalo |
	accionAlClic := unBloque.
	self extent: 72 @ 92.
	self removeAllMorphs.

	estaSeleccionada
		ifTrue: [
			self color: (Color r: 1.0 g: 0.97 b: 0.8).
			self borderColor: Color orange.
			self borderWidth: 3 ]
		ifFalse: [
			estaLibre
				ifTrue: [
					self color: Color white.
					self borderColor: Color darkGray.
					self borderWidth: 2 ]
				ifFalse: [
					self color: (Color r: 0.82 g: 0.82 b: 0.82).
					self borderColor: Color gray.
					self borderWidth: 1 ] ].

	colorTexto := self colorTextoParaCarta: unaCarta libre: estaLibre.
	textoPalo := self etiquetaCortaParaPalo: unaCarta palo.

	self agregarEtiqueta: unaCarta nombreDelValor color: colorTexto desplazamiento: 8 @ 8.
	self agregarEtiqueta: textoPalo color: colorTexto desplazamiento: 10 @ 42.
	self agregarEtiqueta: unaCarta nombreDelValor color: colorTexto desplazamiento: 48 @ 70
]

{ #category : 'initialization' }
CartaMorph >> configurarPozoVacio [
	accionAlClic := nil.
	self extent: 72 @ 92.
	self color: (Color r: 0.09 g: 0.32 b: 0.17).
	self borderColor: Color lightGray.
	self borderWidth: 1.
	self removeAllMorphs.
	self agregarEtiqueta: 'Pozo' color: Color lightGray desplazamiento: 20 @ 38
]

{ #category : 'initialization' }
CartaMorph >> configurarReservaConCantidad: unaCantidad accion: unBloque [
	accionAlClic := unBloque.
	self extent: 72 @ 92.
	self removeAllMorphs.

	unaCantidad > 0
		ifTrue: [
			self color: (Color r: 0.16 g: 0.34 b: 0.62).
			self borderColor: Color white.
			self borderWidth: 2.
			self agregarEtiqueta: 'Reserva' color: Color white desplazamiento: 11 @ 24.
			self agregarEtiqueta: unaCantidad asString color: Color yellow desplazamiento: 28 @ 52 ]
		ifFalse: [
			self color: (Color r: 0.09 g: 0.32 b: 0.17).
			self borderColor: Color lightGray.
			self borderWidth: 1.
			self agregarEtiqueta: 'Vacía' color: Color lightGray desplazamiento: 18 @ 38 ]
]

{ #category : 'private' }
CartaMorph >> etiquetaCortaParaPalo: unPalo [
	unPalo = 'Corazones' ifTrue: [ ^ 'Coraz.' ].
	unPalo = 'Diamantes' ifTrue: [ ^ 'Diam.' ].
	unPalo = 'Tréboles' ifTrue: [ ^ 'Tréb.' ].
	^ 'Picas'
]

{ #category : 'event handling' }
CartaMorph >> handlesMouseDown: anEvent [
	^ accionAlClic notNil
]

{ #category : 'initialization' }
CartaMorph >> initialize [
	super initialize.
	self extent: 72 @ 92
]

{ #category : 'event handling' }
CartaMorph >> mouseDown: anEvent [
	accionAlClic ifNotNil: [ accionAlClic value ]
]
