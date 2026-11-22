"
Representa visualmente una carta (o un casillero de reserva/pozo) en Morphic para el Solitario de Pirámide.
Carga y cachea la imagen JPG correspondiente al palo y valor desde la carpeta assets (con respaldo en texto si falta el archivo),
atenúa cartas cubiertas, resalta la carta seleccionada y ejecuta un bloque de acción al hacer clic.
"
Class {
	#name : 'CartaMorph',
	#superclass : 'BorderedMorph',
	#instVars : [
		'accionAlClic'
	],
	#classVars : [
		'ImagenesCache'
	],
	#category : 'SolitarioPiramide-UI',
	#package : 'SolitarioPiramide-UI'
}

{ #category : 'assets' }
CartaMorph class >> archivoImagenParaCarta: unaCarta [
	| directorio datosPalo nombreArchivo |
	directorio := self directorioAssets.
	directorio ifNil: [ ^ nil ].
	datosPalo := self carpetaYPrefijoParaPalo: unaCarta palo.
	datosPalo ifNil: [ ^ nil ].
	nombreArchivo := datosPalo second , '-' , unaCarta nombreDelValor , '.jpg'.
	^ directorio / datosPalo first / nombreArchivo
]

{ #category : 'assets' }
CartaMorph class >> carpetaYPrefijoParaPalo: unPalo [
	unPalo = 'Corazones' ifTrue: [ ^ #('corazones' 'IQ') ].
	unPalo = 'Diamantes' ifTrue: [ ^ #('diamantes' 'IM') ].
	unPalo = 'Picas' ifTrue: [ ^ #('picas' 'IEM') ].
	unPalo = 'Tréboles' ifTrue: [ ^ #('treboles' 'ISI') ].
	^ nil
]

{ #category : 'assets' }
CartaMorph class >> directorioAssets [
	| candidatos |
	[
		| repo |
		repo := IceRepository registry
			detect: [ :cadaRepo |
				cadaRepo location notNil and: [
					(cadaRepo location / 'assets' / 'corazones') exists ] ]
			ifNone: [ nil ].
		repo ifNotNil: [ ^ repo location / 'assets' ]
	] on: Error do: [ :ex | ].

	candidatos := {
		FileLocator imageDirectory / 'pharo-local' / 'iceberg' / 'RetamozoIvo' / 'solitario-piramide' / 'assets'.
		FileLocator imageDirectory / 'assets'.
		FileLocator workingDirectory / 'assets' }.
	^ candidatos
		detect: [ :unDirectorio | unDirectorio exists ]
		ifNone: [ nil ]
]

{ #category : 'assets' }
CartaMorph class >> imagenParaCarta: unaCarta [
	| tamano clave archivo formOriginal escala formEscalado |
	tamano := 70 @ 90.
	clave := unaCarta palo , '-' , unaCarta nombreDelValor.
	(self imagenesCache at: clave ifAbsent: [ nil ])
		ifNotNil: [ :formEnCache |
			formEnCache extent = tamano ifTrue: [ ^ formEnCache ] ].
	archivo := self archivoImagenParaCarta: unaCarta.
	(archivo isNil or: [ archivo exists not ]) ifTrue: [ ^ nil ].
	^ [
		formOriginal := archivo binaryReadStreamDo: [ :stream |
			ImageReadWriter formFromStream: stream ].
		escala := (tamano x / formOriginal width) @ (tamano y / formOriginal height).
		formEscalado := formOriginal
			magnify: formOriginal boundingBox
			by: escala
			smoothing: 2.
		self imagenesCache at: clave put: formEscalado.
		formEscalado
	] on: Error do: [ :ex | nil ]
]

{ #category : 'assets' }
CartaMorph class >> imagenesCache [
	^ ImagenesCache ifNil: [ ImagenesCache := Dictionary new ]
]

{ #category : 'assets' }
CartaMorph class >> limpiarCacheImagenes [
	ImagenesCache := nil
]

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
CartaMorph >> agregarImagenDeCarta: unForm libre: estaLibre seleccionada: estaSeleccionada [
	| imagenMorph desplazamiento |
	imagenMorph := ImageMorph new
		form: unForm;
		yourself.
	desplazamiento := ((self width - unForm width) // 2) @ ((self height - unForm height) // 2).
	imagenMorph position: self position + desplazamiento.
	self addMorph: imagenMorph.

	estaLibre ifFalse: [
		| velo |
		velo := Morph new
			color: (Color black alpha: 0.35);
			extent: self extent - (2 @ 2);
			position: self position + (1 @ 1);
			yourself.
		self addMorph: velo ].

	estaSeleccionada ifTrue: [
		| marcoSeleccion |
		marcoSeleccion := BorderedMorph new
			color: Color transparent;
			borderColor: Color orange;
			borderWidth: 3;
			extent: self extent;
			position: self position;
			yourself.
		self addMorph: marcoSeleccion ]
]

{ #category : 'private' }
CartaMorph >> agregarTextoRespaldoParaCarta: unaCarta libre: estaLibre [
	| colorTexto textoPalo |
	colorTexto := self colorTextoParaCarta: unaCarta libre: estaLibre.
	textoPalo := self etiquetaCortaParaPalo: unaCarta palo.

	self agregarEtiqueta: unaCarta nombreDelValor color: colorTexto desplazamiento: 8 @ 8.
	self agregarEtiqueta: textoPalo color: colorTexto desplazamiento: 10 @ 42.
	self agregarEtiqueta: unaCarta nombreDelValor color: colorTexto desplazamiento: 48 @ 70
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
	| imagenForm |
	accionAlClic := unBloque.
	self extent: 72 @ 92.
	self removeAllMorphs.

	estaSeleccionada
		ifTrue: [
			self color: (Color r: 1.0 g: 0.92 b: 0.55).
			self borderColor: Color orange.
			self borderWidth: 3 ]
		ifFalse: [
			estaLibre
				ifTrue: [
					self color: Color white.
					self borderColor: Color darkGray.
					self borderWidth: 1 ]
				ifFalse: [
					self color: (Color r: 0.82 g: 0.82 b: 0.82).
					self borderColor: Color gray.
					self borderWidth: 1 ] ].

	imagenForm := self class imagenParaCarta: unaCarta.
	imagenForm
		ifNotNil: [
			self agregarImagenDeCarta: imagenForm libre: estaLibre seleccionada: estaSeleccionada ]
		ifNil: [
			self agregarTextoRespaldoParaCarta: unaCarta libre: estaLibre ]
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
