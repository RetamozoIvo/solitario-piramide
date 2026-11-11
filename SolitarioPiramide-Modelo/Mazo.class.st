Class {
	#name : 'Mazo',
	#superclass : 'Object',
	#instVars : [
		'cartas'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'as yet unclassified' }
Mazo >> cantidadDeCartas [
    ^ cartas size.
]

{ #category : 'as yet unclassified' }
Mazo >> estaVacio [
    ^ cartas isEmpty.
]

{ #category : 'initialization' }
Mazo >> initialize [
    "Inicializa el mazo con las 52 cartas de la baraja francesa"
    super initialize.
    cartas := OrderedCollection new.
    
    #('Corazones' 'Diamantes' 'Tréboles' 'Picas') do: [ :unPalo |
        1 to: 13 do: [ :unValor |
            cartas add: (Carta palo: unPalo valor: unValor)
        ]
    ].
]

{ #category : 'as yet unclassified' }
Mazo >> mezclar [
    "Desordena aleatoriamente las cartas usando el mensaje nativo de Pharo"
    cartas := cartas shuffled.
]

{ #category : 'as yet unclassified' }
Mazo >> tomarCarta [
    "Saca y devuelve la primera carta del mazo. Falla si está vacío."
    ^ cartas removeFirst.
]
