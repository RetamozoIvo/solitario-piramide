"
Representa el pozo auxiliar del Solitario de Pirámide, compuesto por una reserva (Mazo) y una pila de descarte.
Al robar se pasa la carta superior de la reserva al descarte; al retirar la visible, vuelve a quedar visible la carta anterior del descarte.
Cuando la reserva queda vacía, permite reciclar y mezclar nuevamente las cartas del descarte en la reserva.
"
Class {
	#name : 'Pozo',
	#superclass : 'Object',
	#instVars : [
		'reserva',
		'descarte'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'instance creation' }
Pozo class >> conReserva: unMazo [
	^ self basicNew initializeConReserva: unMazo
]

{ #category : 'accessing' }
Pozo >> cantidadEnDescarte [
	^ descarte size
]

{ #category : 'accessing' }
Pozo >> cantidadEnReserva [
	^ reserva cantidadDeCartas
]

{ #category : 'accessing' }
Pozo >> cartaVisible [
	^ descarte isEmpty
		ifTrue: [ nil ]
		ifFalse: [ descarte last ]
]

{ #category : 'accessing' }
Pozo >> descarte [
	^ descarte copy
]

{ #category : 'operations' }
Pozo >> deshacerRobar [
	| carta |
	descarte isEmpty ifTrue: [ ^ nil ].
	carta := descarte removeLast.
	reserva devolverCarta: carta.
	^ carta
]

{ #category : 'operations' }
Pozo >> devolverAlDescarte: unaCarta [
	descarte addLast: unaCarta
]

{ #category : 'initialization' }
Pozo >> initialize [
	self initializeConReserva: Mazo new
]

{ #category : 'initialization' }
Pozo >> initializeConReserva: unMazo [
	super initialize.
	reserva := unMazo.
	descarte := OrderedCollection new
]

{ #category : 'testing' }
Pozo >> puedeReciclar [
	^ reserva estaVacio and: [ descarte isEmpty not ]
]

{ #category : 'testing' }
Pozo >> puedeRobar [
	^ reserva estaVacio not
]

{ #category : 'operations' }
Pozo >> reciclar [
	self puedeReciclar ifFalse: [ ^ false ].
	reserva agregarCartas: descarte.
	descarte removeAll.
	reserva mezclar.
	^ true
]

{ #category : 'accessing' }
Pozo >> reserva [
	^ reserva
]

{ #category : 'operations' }
Pozo >> restaurarDescarte: unaColeccion [
	reserva vaciar.
	descarte := OrderedCollection withAll: unaColeccion
]

{ #category : 'operations' }
Pozo >> retirarVisible [
	descarte isEmpty ifTrue: [ ^ nil ].
	^ descarte removeLast
]

{ #category : 'operations' }
Pozo >> robar [
	| carta |
	self puedeRobar ifFalse: [ ^ nil ].
	carta := reserva tomarCarta.
	descarte addLast: carta.
	^ carta
]
