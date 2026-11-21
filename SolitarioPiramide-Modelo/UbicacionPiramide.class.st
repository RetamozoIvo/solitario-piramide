"
Representa la ubicación de una carta dentro de la pirámide mediante su fila (1 a 7) y posición (1 a fila).
"
Class {
	#name : 'UbicacionPiramide',
	#superclass : 'UbicacionCarta',
	#instVars : [
		'fila',
		'posicion'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'instance creation' }
UbicacionPiramide class >> fila: unaFila posicion: unaPosicion [
	^ self basicNew initializeFila: unaFila posicion: unaPosicion
]

{ #category : 'comparing' }
UbicacionPiramide >> = otraUbicacion [
	self == otraUbicacion ifTrue: [ ^ true ].
	self class = otraUbicacion class ifFalse: [ ^ false ].
	^ fila = otraUbicacion fila and: [ posicion = otraUbicacion posicion ]
]

{ #category : 'accessing' }
UbicacionPiramide >> cartaEn: unJuego [
	carta := unJuego piramide cartaEnFila: fila posicion: posicion.
	^ carta
]

{ #category : 'operations' }
UbicacionPiramide >> devolver: unaCarta a: unJuego [
	carta := unaCarta.
	unJuego piramide colocarCarta: unaCarta enFila: fila posicion: posicion
]

{ #category : 'testing' }
UbicacionPiramide >> estaDisponibleEn: unJuego [
	carta := unJuego piramide cartaEnFila: fila posicion: posicion.
	^ unJuego piramide estaLibreFila: fila posicion: posicion
]

{ #category : 'accessing' }
UbicacionPiramide >> fila [
	^ fila
]

{ #category : 'accessing' }
UbicacionPiramide >> filaAfectada [
	^ fila
]

{ #category : 'comparing' }
UbicacionPiramide >> hash [
	^ fila hash bitXor: posicion hash
]

{ #category : 'initialization' }
UbicacionPiramide >> initializeFila: unaFila posicion: unaPosicion [
	super initialize.
	fila := unaFila.
	posicion := unaPosicion
]

{ #category : 'accessing' }
UbicacionPiramide >> posicion [
	^ posicion
]

{ #category : 'operations' }
UbicacionPiramide >> retirarDe: unJuego [
	carta := unJuego piramide removerCartaEnFila: fila posicion: posicion.
	^ carta
]
