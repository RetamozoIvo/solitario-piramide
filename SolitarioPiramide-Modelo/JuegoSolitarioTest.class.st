Class {
	#name : 'JuegoSolitarioTest',
	#superclass : 'TestCase',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'tests' }
JuegoSolitarioTest >> testInicializacionDelJuego [
	| juego |
	juego := JuegoSolitario new.
	
	self assert: juego puntaje equals: 0.
	
	"Debe haber una carta visible en el pozo auxiliar lista para usarse"
	self deny: juego cartaPozoVisible isNil.
]
