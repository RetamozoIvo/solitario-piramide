Class {
	#name : 'Piramide',
	#superclass : 'Object',
	#instVars : [
		'cartasEnJuego'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'as yet unclassified' }
Piramide >> cartaEnFila: fila posicion: posicion [
	"Devuelve la carta en esa posición, o nil si ya fue eliminada"
	^ cartasEnJuego at: (fila @ posicion) ifAbsent: [ nil ].
]

{ #category : 'as yet unclassified' }
Piramide >> estaLibreFila: fila posicion: posicion [
	| cubiertaIzquierda cubiertaDerecha |
	
	"Si es la base de la pirámide (fila 7), siempre está libre (mientras no la hayan eliminado)"
	fila = 7 ifTrue: [ ^ true ].
	
	"Verificamos si existen las cartas que la pisan"
	cubiertaIzquierda := cartasEnJuego includesKey: ((fila + 1) @ posicion).
	cubiertaDerecha := cartasEnJuego includesKey: ((fila + 1) @ (posicion + 1)).
	
	"Está libre si NO está cubierta por la izquierda Y NO está cubierta por la derecha"
	^ (cubiertaIzquierda or: [ cubiertaDerecha ]) not.
]

{ #category : 'initialization' }
Piramide >> initialize [
	super initialize.
	cartasEnJuego := Dictionary new.
]

{ #category : 'as yet unclassified' }
Piramide >> removerCartaEnFila: fila posicion: posicion [
	cartasEnJuego removeKey: (fila @ posicion) ifAbsent: [ ].
]

{ #category : 'as yet unclassified' }
Piramide >> repartirDe: unMazo [
	"Toma cartas del mazo y las acomoda en forma de pirámide (7 filas)"
	1 to: 7 do: [ :fila |
		1 to: fila do: [ :posicion |
			cartasEnJuego at: (fila @ posicion) put: unMazo tomarCarta
		]
	].
]
