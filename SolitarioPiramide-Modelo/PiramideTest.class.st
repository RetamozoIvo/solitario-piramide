Class {
	#name : 'PiramideTest',
	#superclass : 'TestCase',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'tests' }
PiramideTest >> testLogicaDeCartasLibres [
	| mazo piramide |
	
	mazo := Mazo new.
	piramide := Piramide new.
	piramide repartirDe: mazo.
	
	"La punta (1,1) NO debería estar libre al empezar"
	self deny: (piramide estaLibreFila: 1 posicion: 1).
	
	"Las cartas de la base (fila 7) SÍ deberían estar libres al empezar"
	self assert: (piramide estaLibreFila: 7 posicion: 1).
	self assert: (piramide estaLibreFila: 7 posicion: 7).
	
	"Simulamos que el jugador elimina las dos cartas que cubren a la (6,1)"
	piramide removerCartaEnFila: 7 posicion: 1.
	piramide removerCartaEnFila: 7 posicion: 2.
	
	"Ahora la carta en la fila 6, posición 1 DEBERÍA estar libre"
	self assert: (piramide estaLibreFila: 6 posicion: 1).
]
