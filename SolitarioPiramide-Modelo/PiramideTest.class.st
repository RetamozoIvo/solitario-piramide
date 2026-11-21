"
Pruebas unitarias SUnit para la clase Piramide.
Verifica el estado inicial vacío, el reparto de 28 cartas en 7 filas,
la remoción de cartas, las cartas libres, el vaciado de filas y la regla de disponibilidad.
"
Class {
	#name : 'PiramideTest',
	#superclass : 'TestCase',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'tests' }
PiramideTest >> testCantidadDeCartasYEstaVacia [
	| mazo piramide |
	piramide := Piramide new.
	self assert: piramide estaVacia.
	self assert: piramide cantidadDeCartas equals: 0.

	mazo := Mazo new.
	piramide repartirDe: mazo.
	self deny: piramide estaVacia.
	self assert: piramide cantidadDeCartas equals: 28.

	1 to: 7 do: [ :fila |
		1 to: fila do: [ :posicion |
			piramide removerCartaEnFila: fila posicion: posicion ] ].
	self assert: piramide estaVacia.
	self assert: piramide cantidadDeCartas equals: 0
]

{ #category : 'tests' }
PiramideTest >> testCartasLibres [
	| mazo piramide libres |
	mazo := Mazo new.
	piramide := Piramide new.
	piramide repartirDe: mazo.

	libres := piramide cartasLibres.
	self assert: libres size equals: 7.
	1 to: 7 do: [ :posicion |
		self assert: (libres includes: (piramide cartaEnFila: 7 posicion: posicion)) ].

	piramide removerCartaEnFila: 7 posicion: 1.
	piramide removerCartaEnFila: 7 posicion: 2.
	libres := piramide cartasLibres.
	self assert: libres size equals: 6.
	self assert: (libres includes: (piramide cartaEnFila: 6 posicion: 1))
]

{ #category : 'tests' }
PiramideTest >> testEstaLibreEnBaseYFilasSuperiores [
	| mazo piramide |
	mazo := Mazo new.
	piramide := Piramide new.
	piramide repartirDe: mazo.

	1 to: 7 do: [ :posicion |
		self assert: (piramide estaLibreFila: 7 posicion: posicion) ].

	1 to: 6 do: [ :fila |
		1 to: fila do: [ :posicion |
			self deny: (piramide estaLibreFila: fila posicion: posicion) ] ]
]

{ #category : 'tests' }
PiramideTest >> testEstaVaciaLaFila [
	| mazo piramide |
	mazo := Mazo new.
	piramide := Piramide new.
	piramide repartirDe: mazo.

	self deny: (piramide estaVaciaLaFila: 7).
	1 to: 6 do: [ :posicion |
		piramide removerCartaEnFila: 7 posicion: posicion ].
	self deny: (piramide estaVaciaLaFila: 7).

	piramide removerCartaEnFila: 7 posicion: 7.
	self assert: (piramide estaVaciaLaFila: 7)
]

{ #category : 'tests' }
PiramideTest >> testInicializacionVacia [
	| piramide |
	piramide := Piramide new.

	self assert: piramide estaVacia.
	self assert: (piramide cartaEnFila: 1 posicion: 1) isNil.
	self deny: (piramide estaLibreFila: 1 posicion: 1).
	self deny: (piramide estaLibreFila: 7 posicion: 1)
]

{ #category : 'tests' }
PiramideTest >> testLiberarCartaAlRemoverInferiores [
	| mazo piramide |
	mazo := Mazo new.
	piramide := Piramide new.
	piramide repartirDe: mazo.

	self deny: (piramide estaLibreFila: 6 posicion: 1).

	piramide removerCartaEnFila: 7 posicion: 1.
	self deny: (piramide estaLibreFila: 6 posicion: 1).

	piramide removerCartaEnFila: 7 posicion: 2.
	self assert: (piramide estaLibreFila: 6 posicion: 1)
]

{ #category : 'tests' }
PiramideTest >> testRemoverCarta [
	| mazo piramide cartaOriginal cartaRemovida |
	mazo := Mazo new.
	piramide := Piramide new.
	piramide repartirDe: mazo.

	cartaOriginal := piramide cartaEnFila: 7 posicion: 3.
	cartaRemovida := piramide removerCartaEnFila: 7 posicion: 3.

	self assert: cartaRemovida equals: cartaOriginal.
	self assert: (piramide cartaEnFila: 7 posicion: 3) isNil.
	self deny: (piramide estaLibreFila: 7 posicion: 3).
	self assert: (piramide removerCartaEnFila: 7 posicion: 3) isNil
]

{ #category : 'tests' }
PiramideTest >> testRepartirDeMazo [
	| mazo piramide carta |
	mazo := Mazo new.
	piramide := Piramide new.
	piramide repartirDe: mazo.

	self assert: mazo cantidadDeCartas equals: 24.

	1 to: 7 do: [ :fila |
		1 to: fila do: [ :posicion |
			carta := piramide cartaEnFila: fila posicion: posicion.
			self assert: (carta isKindOf: Carta) ] ].

	self assert: (piramide cartaEnFila: 1 posicion: 2) isNil.
	self assert: (piramide cartaEnFila: 8 posicion: 1) isNil
]
