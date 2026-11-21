"
Pruebas unitarias SUnit para la clase Carta.
Verifica la creación válida e inválida, inmutabilidad, representación textual, igualdad, hash y reglas del juego.
"
Class {
	#name : 'CartaTest',
	#superclass : 'TestCase',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'tests' }
CartaTest >> testCreacionYAccessors [
	| asCorazones sieteDiamantes diezTreboles reyPicas |
	asCorazones := Carta palo: 'Corazones' valor: 1.
	sieteDiamantes := Carta palo: 'Diamantes' valor: 7.
	diezTreboles := Carta palo: 'Tréboles' valor: 10.
	reyPicas := Carta palo: 'Picas' valor: 13.

	self assert: asCorazones palo equals: 'Corazones'.
	self assert: asCorazones valor equals: 1.
	self assert: sieteDiamantes palo equals: 'Diamantes'.
	self assert: sieteDiamantes valor equals: 7.
	self assert: diezTreboles palo equals: 'Tréboles'.
	self assert: diezTreboles valor equals: 10.
	self assert: reyPicas palo equals: 'Picas'.
	self assert: reyPicas valor equals: 13.

	self deny: (asCorazones respondsTo: #palo:).
	self deny: (asCorazones respondsTo: #valor:)
]

{ #category : 'tests' }
CartaTest >> testEsRey [
	| rey as reina cartaComun |
	rey := Carta palo: 'Diamantes' valor: 13.
	as := Carta palo: 'Picas' valor: 1.
	reina := Carta palo: 'Corazones' valor: 12.
	cartaComun := Carta palo: 'Tréboles' valor: 5.

	self assert: rey esRey.
	self deny: as esRey.
	self deny: reina esRey.
	self deny: cartaComun esRey
]

{ #category : 'tests' }
CartaTest >> testIgualdadYHash [
	| carta1 carta2 distintoPalo distintoValor |
	carta1 := Carta palo: 'Picas' valor: 13.
	carta2 := Carta palo: 'Picas' valor: 13.
	distintoPalo := Carta palo: 'Corazones' valor: 13.
	distintoValor := Carta palo: 'Picas' valor: 12.

	self assert: carta1 equals: carta1.
	self assert: carta1 equals: carta2.
	self assert: carta1 hash equals: carta2 hash.
	self deny: (carta1 = distintoPalo).
	self deny: (carta1 = distintoValor).
	self deny: (carta1 = nil).
	self deny: (carta1 = 'K de Picas')
]

{ #category : 'tests' }
CartaTest >> testNombreDelValor [
	| as dos diez jota reina rey |
	as := Carta palo: 'Picas' valor: 1.
	dos := Carta palo: 'Corazones' valor: 2.
	diez := Carta palo: 'Diamantes' valor: 10.
	jota := Carta palo: 'Corazones' valor: 11.
	reina := Carta palo: 'Diamantes' valor: 12.
	rey := Carta palo: 'Tréboles' valor: 13.

	self assert: as nombreDelValor isString.
	self assert: as nombreDelValor equals: 'A'.
	self assert: dos nombreDelValor isString.
	self assert: dos nombreDelValor equals: '2'.
	self assert: diez nombreDelValor isString.
	self assert: diez nombreDelValor equals: '10'.
	self assert: jota nombreDelValor isString.
	self assert: jota nombreDelValor equals: 'J'.
	self assert: reina nombreDelValor isString.
	self assert: reina nombreDelValor equals: 'Q'.
	self assert: rey nombreDelValor isString.
	self assert: rey nombreDelValor equals: 'K'
]

{ #category : 'tests' }
CartaTest >> testPaloInvalido [
	self should: [ Carta palo: 'Oros' valor: 5 ] raise: Error.
	self should: [ Carta palo: '' valor: 5 ] raise: Error.
	self should: [ Carta palo: nil valor: 5 ] raise: Error.
	self should: [ Carta palo: #Picas valor: 5 ] raise: Error
]

{ #category : 'tests' }
CartaTest >> testPrintOn [
	| reyPicas asCorazones diezTreboles |
	reyPicas := Carta palo: 'Picas' valor: 13.
	asCorazones := Carta palo: 'Corazones' valor: 1.
	diezTreboles := Carta palo: 'Tréboles' valor: 10.

	self assert: reyPicas printString equals: 'K de Picas'.
	self assert: asCorazones printString equals: 'A de Corazones'.
	self assert: diezTreboles printString equals: '10 de Tréboles'
]

{ #category : 'tests' }
CartaTest >> testSuma13Con [
	| as carta2 carta5 carta8 jota reina rey |
	as := Carta palo: 'Picas' valor: 1.
	carta2 := Carta palo: 'Tréboles' valor: 2.
	carta5 := Carta palo: 'Picas' valor: 5.
	carta8 := Carta palo: 'Corazones' valor: 8.
	jota := Carta palo: 'Diamantes' valor: 11.
	reina := Carta palo: 'Corazones' valor: 12.
	rey := Carta palo: 'Picas' valor: 13.

	self assert: (carta8 suma13Con: carta5).
	self assert: (jota suma13Con: carta2).
	self assert: (reina suma13Con: as).
	self deny: (carta8 suma13Con: jota).
	self deny: (carta5 suma13Con: carta5).
	self deny: (rey suma13Con: as).
	self deny: (rey suma13Con: carta5).
	self deny: (rey suma13Con: rey)
]

{ #category : 'tests' }
CartaTest >> testValorInvalido [
	self should: [ Carta palo: 'Picas' valor: 0 ] raise: Error.
	self should: [ Carta palo: 'Picas' valor: -3 ] raise: Error.
	self should: [ Carta palo: 'Picas' valor: 14 ] raise: Error.
	self should: [ Carta palo: 'Picas' valor: 5.5 ] raise: Error.
	self should: [ Carta palo: 'Picas' valor: '5' ] raise: Error.
	self should: [ Carta palo: 'Picas' valor: nil ] raise: Error
]
