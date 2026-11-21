"
Representa un mazo de cartas de la baraja francesa para el Solitario de Pirámide.
Por defecto se inicializa con las 52 cartas estándar, y también puede crearse con una secuencia específica de cartas para pruebas deterministas.
"
Class {
	#name : 'Mazo',
	#superclass : 'Object',
	#instVars : [
		'cartas'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'instance creation' }
Mazo class >> conCartas: unaColeccion [
	^ self basicNew initializeConCartas: unaColeccion
]

{ #category : 'accessing' }
Mazo >> cantidadDeCartas [
	^ cartas size
]

{ #category : 'operations' }
Mazo >> devolverCarta: unaCarta [
	cartas addFirst: unaCarta
]

{ #category : 'testing' }
Mazo >> estaVacio [
	^ cartas isEmpty
]

{ #category : 'initialization' }
Mazo >> initialize [
	super initialize.
	cartas := OrderedCollection new.
	#('Corazones' 'Diamantes' 'Tréboles' 'Picas') do: [ :unPalo |
		1 to: 13 do: [ :unValor |
			cartas add: (Carta palo: unPalo valor: unValor) ] ]
]

{ #category : 'initialization' }
Mazo >> initializeConCartas: unaColeccion [
	super initialize.
	cartas := OrderedCollection withAll: unaColeccion
]

{ #category : 'operations' }
Mazo >> mezclar [
	cartas shuffle
]

{ #category : 'operations' }
Mazo >> tomarCarta [
	self estaVacio ifTrue: [ ^ nil ].
	^ cartas removeFirst
]
