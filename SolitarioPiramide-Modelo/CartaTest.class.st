Class {
	#name : 'CartaTest',
	#superclass : 'TestCase',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'tests' }
CartaTest >> testEsRey [
    | rey otraCarta |
    
    rey := Carta palo: 'Diamantes' valor: 13.
    otraCarta := Carta palo: 'Tréboles' valor: 5.
    
    self assert: rey esRey.
    self deny: otraCarta esRey.
]

{ #category : 'tests' }
CartaTest >> testNombreDelValor [
    | as jota reina rey cartaComun |
    
    as := Carta palo: 'Picas' valor: 1.
    jota := Carta palo: 'Corazones' valor: 11.
    reina := Carta palo: 'Diamantes' valor: 12.
    rey := Carta palo: 'Tréboles' valor: 13.
    cartaComun := Carta palo: 'Picas' valor: 7.
    
    self assert: as nombreDelValor equals: 'A'.
    self assert: jota nombreDelValor equals: 'J'.
    self assert: reina nombreDelValor equals: 'Q'.
    self assert: rey nombreDelValor equals: 'K'.
    self assert: cartaComun nombreDelValor equals: 7.
]

{ #category : 'tests' }
CartaTest >> testSuma13Con [
    | carta8 carta5 cartaJ carta2 |
    
    carta8 := Carta palo: 'Corazones' valor: 8.
    carta5 := Carta palo: 'Picas' valor: 5.
    cartaJ := Carta palo: 'Diamantes' valor: 11.
    carta2 := Carta palo: 'Tréboles' valor: 2.
    
    self assert: (carta8 suma13Con: carta5).
    self assert: (cartaJ suma13Con: carta2).
    self deny: (carta8 suma13Con: cartaJ).
]
