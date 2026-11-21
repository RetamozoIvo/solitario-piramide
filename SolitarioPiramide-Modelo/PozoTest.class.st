"
Pruebas unitarias SUnit para la clase Pozo.
Verifica robar desde la reserva, consultar la carta visible, retirar la visible revelando la anterior,
el comportamiento con reserva vacía y el soporte para deshacer.
"
Class {
	#name : 'PozoTest',
	#superclass : 'TestCase',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'tests' }
PozoTest >> testDeshacerRobarYDevolverAlDescarte [
	| c1 c2 pozo |
	c1 := Carta palo: 'Picas' valor: 3.
	c2 := Carta palo: 'Corazones' valor: 10.
	pozo := Pozo conReserva: (Mazo conCartas: { c1. c2 }).

	pozo robar.
	pozo robar.
	self assert: pozo cartaVisible equals: c2.
	self deny: pozo puedeRobar.

	pozo deshacerRobar.
	self assert: pozo cartaVisible equals: c1.
	self assert: pozo puedeRobar.
	self assert: pozo cantidadEnReserva equals: 1.

	pozo retirarVisible.
	self assert: pozo cartaVisible isNil.
	pozo devolverAlDescarte: c1.
	self assert: pozo cartaVisible equals: c1
]

{ #category : 'tests' }
PozoTest >> testRobarRetirarYRevelarAnterior [
	| c1 c2 c3 pozo |
	c1 := Carta palo: 'Picas' valor: 4.
	c2 := Carta palo: 'Diamantes' valor: 9.
	c3 := Carta palo: 'Tréboles' valor: 13.
	pozo := Pozo conReserva: (Mazo conCartas: { c1. c2. c3 }).

	self assert: pozo cartaVisible isNil.
	self assert: pozo puedeRobar.
	self assert: pozo cantidadEnReserva equals: 3.

	self assert: pozo robar equals: c1.
	self assert: pozo cartaVisible equals: c1.
	self assert: pozo cantidadEnReserva equals: 2.

	self assert: pozo robar equals: c2.
	self assert: pozo cartaVisible equals: c2.
	self assert: pozo cantidadEnReserva equals: 1.

	self assert: pozo retirarVisible equals: c2.
	self assert: pozo cartaVisible equals: c1.

	self assert: pozo robar equals: c3.
	self assert: pozo cartaVisible equals: c3.
	self deny: pozo puedeRobar.
	self assert: pozo robar isNil.
	self assert: pozo cartaVisible equals: c3.

	self assert: pozo retirarVisible equals: c3.
	self assert: pozo cartaVisible equals: c1.
	self assert: pozo retirarVisible equals: c1.
	self assert: pozo cartaVisible isNil.
	self assert: pozo retirarVisible isNil
]
