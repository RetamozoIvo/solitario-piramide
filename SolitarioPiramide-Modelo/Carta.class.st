"
Representa una carta inmutable de la baraja francesa para el Solitario de Pirámide.
Cada carta tiene un palo válido ('Corazones', 'Diamantes', 'Tréboles' o 'Picas') y un valor entero entre 1 y 13.
"
Class {
	#name : 'Carta',
	#superclass : 'Object',
	#instVars : [
		'palo',
		'valor'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'instance creation' }
Carta class >> palo: unPalo valor: unValor [
	self validarPalo: unPalo.
	self validarValor: unValor.
	^ self new initializePalo: unPalo valor: unValor
]

{ #category : 'accessing' }
Carta class >> palosValidos [
	^ #('Corazones' 'Diamantes' 'Tréboles' 'Picas')
]

{ #category : 'testing' }
Carta class >> validarPalo: unPalo [
	(unPalo isString and: [ unPalo isSymbol not and: [ self palosValidos includes: unPalo ] ])
		ifFalse: [ self error: 'El palo debe ser uno de: Corazones, Diamantes, Tréboles o Picas' ]
]

{ #category : 'testing' }
Carta class >> validarValor: unValor [
	(unValor isInteger and: [ unValor between: 1 and: 13 ])
		ifFalse: [ self error: 'El valor de la carta debe ser un entero entre 1 y 13' ]
]

{ #category : 'comparing' }
Carta >> = otraCarta [
	self == otraCarta ifTrue: [ ^ true ].
	self class = otraCarta class ifFalse: [ ^ false ].
	^ palo = otraCarta palo and: [ valor = otraCarta valor ]
]

{ #category : 'testing' }
Carta >> esRey [
	^ valor = 13
]

{ #category : 'comparing' }
Carta >> hash [
	^ palo hash bitXor: valor hash
]

{ #category : 'initialization' }
Carta >> initializePalo: unPalo valor: unValor [
	palo ifNotNil: [ self error: 'La carta es inmutable y no puede modificarse después de creada' ].
	palo := unPalo.
	valor := unValor
]

{ #category : 'accessing' }
Carta >> nombreDelValor [
	valor = 1 ifTrue: [ ^ 'A' ].
	valor = 11 ifTrue: [ ^ 'J' ].
	valor = 12 ifTrue: [ ^ 'Q' ].
	valor = 13 ifTrue: [ ^ 'K' ].
	^ valor asString
]

{ #category : 'accessing' }
Carta >> palo [
	^ palo
]

{ #category : 'printing' }
Carta >> printOn: aStream [
	aStream
		nextPutAll: self nombreDelValor;
		nextPutAll: ' de ';
		nextPutAll: palo
]

{ #category : 'testing' }
Carta >> suma13Con: otraCarta [
	^ (valor + otraCarta valor) = 13
]

{ #category : 'accessing' }
Carta >> valor [
	^ valor
]
