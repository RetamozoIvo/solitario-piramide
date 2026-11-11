Class {
	#name : 'JuegoSolitario',
	#superclass : 'Object',
	#instVars : [
		'mazo',
		'piramide',
		'cartaPozoVisible',
		'puntaje'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'accessing' }
JuegoSolitario >> cartaPozoVisible [
	^ cartaPozoVisible
]

{ #category : 'initialization' }
JuegoSolitario >> initialize [
	super initialize.
	puntaje := 0.
	
	mazo := Mazo new.
	mazo mezclar.
	
	piramide := Piramide new.
	piramide repartirDe: mazo.
	
	"Preparamos la primera carta visible del pozo auxiliar"
	self sacarCartaDelPozo.
]

{ #category : 'accessing' }
JuegoSolitario >> puntaje [
	^ puntaje
]

{ #category : 'as yet unclassified' }
JuegoSolitario >> sacarCartaDelPozo [
	"Toma una carta del mazo para el pozo auxiliar. Si el mazo se vacía, queda en nil."
	cartaPozoVisible := mazo estaVacio 
		ifTrue: [ nil ] 
		ifFalse: [ mazo tomarCarta ].
]

{ #category : 'as yet unclassified' }
JuegoSolitario >> sumarPuntos: cantidad [
	puntaje := puntaje + cantidad.
]
