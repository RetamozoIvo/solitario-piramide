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

{ #category : 'tests' }
PozoTest >> testReciclarYMezclarCuandoReservaEstaVacia [
	| cartasOriginales pozo ordenReciclado descarteOriginal |
	cartasOriginales := (1 to: 12) collect: [ :v | Carta palo: 'Corazones' valor: v ].
	pozo := Pozo conReserva: (Mazo conCartas: cartasOriginales).

	self deny: pozo puedeReciclar.
	self deny: pozo reciclar.

	12 timesRepeat: [ pozo robar ].
	self deny: pozo puedeRobar.
	self assert: pozo puedeReciclar.
	self assert: pozo cantidadEnReserva equals: 0.
	self assert: pozo cantidadEnDescarte equals: 12.
	descarteOriginal := pozo descarte.

	self assert: pozo reciclar.
	self assert: pozo puedeRobar.
	self deny: pozo puedeReciclar.
	self assert: pozo cantidadEnReserva equals: 12.
	self assert: pozo cantidadEnDescarte equals: 0.
	self assert: pozo cartaVisible isNil.

	ordenReciclado := OrderedCollection new.
	12 timesRepeat: [ ordenReciclado add: pozo robar ].
	self assert: ordenReciclado asSet equals: cartasOriginales asSet.
	self deny: (ordenReciclado = cartasOriginales asOrderedCollection).

	pozo restaurarDescarte: descarteOriginal.
	self assert: pozo cantidadEnReserva equals: 0.
	self assert: pozo descarte equals: descarteOriginal.
	self assert: pozo cartaVisible equals: descarteOriginal last
]
