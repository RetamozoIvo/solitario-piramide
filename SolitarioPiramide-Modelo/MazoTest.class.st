"
Pruebas unitarias SUnit para la clase Mazo.
Verifica la inicialización de las 52 cartas, la mezcla, la extracción, la devolución al tope y la creación determinista.
"
Class {
	#name : 'MazoTest',
	#superclass : 'TestCase',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'tests' }
MazoTest >> testConCartas [
	| c1 c2 mazo |
	c1 := Carta palo: 'Picas' valor: 1.
	c2 := Carta palo: 'Corazones' valor: 13.
	mazo := Mazo conCartas: { c1. c2 }.

	self assert: mazo cantidadDeCartas equals: 2.
	self deny: mazo estaVacio.
	self assert: mazo tomarCarta equals: c1.
	self assert: mazo tomarCarta equals: c2.
	self assert: mazo estaVacio
]

{ #category : 'tests' }
MazoTest >> testDevolverCarta [
	| mazo carta |
	mazo := Mazo new.
	carta := mazo tomarCarta.
	self assert: mazo cantidadDeCartas equals: 51.

	mazo devolverCarta: carta.
	self assert: mazo cantidadDeCartas equals: 52.
	self assert: mazo tomarCarta equals: carta
]

{ #category : 'tests' }
MazoTest >> testInicializacion [
	| mazo nombresUnicos carta |
	mazo := Mazo new.

	self assert: mazo cantidadDeCartas equals: 52.
	self deny: mazo estaVacio.

	nombresUnicos := Set new.
	52 timesRepeat: [
		carta := mazo tomarCarta.
		self assert: (carta isKindOf: Carta).
		nombresUnicos add: carta printString ].

	self assert: nombresUnicos size equals: 52.
	self assert: mazo estaVacio.
	self assert: mazo cantidadDeCartas equals: 0
]

{ #category : 'tests' }
MazoTest >> testMezclar [
	| mazoOriginal mazoMezclado ordenOriginal ordenMezclado |
	mazoOriginal := Mazo new.
	mazoMezclado := Mazo new.
	mazoMezclado mezclar.

	self assert: mazoMezclado cantidadDeCartas equals: 52.

	ordenOriginal := OrderedCollection new.
	ordenMezclado := OrderedCollection new.
	52 timesRepeat: [
		ordenOriginal add: mazoOriginal tomarCarta printString.
		ordenMezclado add: mazoMezclado tomarCarta printString ].

	self assert: ordenMezclado asSet equals: ordenOriginal asSet.
	self deny: (ordenMezclado = ordenOriginal)
]

{ #category : 'tests' }
MazoTest >> testTomarCarta [
	| mazo primeraCarta |
	mazo := Mazo new.
	primeraCarta := mazo tomarCarta.

	self assert: (primeraCarta isKindOf: Carta).
	self assert: mazo cantidadDeCartas equals: 51.
	self deny: mazo estaVacio.

	51 timesRepeat: [ mazo tomarCarta ].

	self assert: mazo estaVacio.
	self assert: mazo cantidadDeCartas equals: 0.
	self assert: mazo tomarCarta isNil
]
