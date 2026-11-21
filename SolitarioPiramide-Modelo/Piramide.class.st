"
Representa la pirámide de 7 filas (28 cartas) del Solitario de Pirámide.
Almacena las cartas en un diccionario indexado por su coordenada (fila @ posicion),
permite repartir desde un mazo, consultar o remover cartas, verificar disponibilidad y detectar filas completas o pirámide vacía.
"
Class {
	#name : 'Piramide',
	#superclass : 'Object',
	#instVars : [
		'cartas'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'accessing' }
Piramide >> cantidadDeCartas [
	^ cartas size
]

{ #category : 'accessing' }
Piramide >> cartaEnFila: unaFila posicion: unaPosicion [
	^ cartas at: unaFila @ unaPosicion ifAbsent: [ nil ]
]

{ #category : 'accessing' }
Piramide >> cartasLibres [
	| libres |
	libres := OrderedCollection new.
	1 to: 7 do: [ :fila |
		1 to: fila do: [ :posicion |
			(self estaLibreFila: fila posicion: posicion)
				ifTrue: [ libres add: (self cartaEnFila: fila posicion: posicion) ] ] ].
	^ libres
]

{ #category : 'operations' }
Piramide >> colocarCarta: unaCarta enFila: unaFila posicion: unaPosicion [
	cartas at: unaFila @ unaPosicion put: unaCarta
]

{ #category : 'testing' }
Piramide >> estaLibreFila: unaFila posicion: unaPosicion [
	| cubiertaIzquierda cubiertaDerecha |
	(cartas includesKey: unaFila @ unaPosicion) ifFalse: [ ^ false ].
	cubiertaIzquierda := cartas includesKey: (unaFila + 1) @ unaPosicion.
	cubiertaDerecha := cartas includesKey: (unaFila + 1) @ (unaPosicion + 1).
	^ cubiertaIzquierda not and: [ cubiertaDerecha not ]
]

{ #category : 'testing' }
Piramide >> estaVacia [
	^ cartas isEmpty
]

{ #category : 'testing' }
Piramide >> estaVaciaLaFila: unaFila [
	1 to: unaFila do: [ :posicion |
		(cartas includesKey: unaFila @ posicion) ifTrue: [ ^ false ] ].
	^ true
]

{ #category : 'initialization' }
Piramide >> initialize [
	super initialize.
	cartas := Dictionary new
]

{ #category : 'operations' }
Piramide >> removerCartaEnFila: unaFila posicion: unaPosicion [
	^ cartas removeKey: unaFila @ unaPosicion ifAbsent: [ nil ]
]

{ #category : 'operations' }
Piramide >> repartirDe: unMazo [
	| carta |
	cartas := Dictionary new.
	1 to: 7 do: [ :fila |
		1 to: fila do: [ :posicion |
			carta := unMazo tomarCarta.
			carta ifNotNil: [ cartas at: fila @ posicion put: carta ] ] ]
]
