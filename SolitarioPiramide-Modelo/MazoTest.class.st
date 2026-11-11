Class {
	#name : 'MazoTest',
	#superclass : 'TestCase',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'tests' }
MazoTest >> testInicializacion [
    | mazo |
    mazo := Mazo new.
    
    "Un mazo nuevo debe tener exactamente 52 cartas"
    self assert: mazo cantidadDeCartas equals: 52.
    
    "Un mazo nuevo no puede estar vacío"
    self deny: mazo estaVacio.
]
