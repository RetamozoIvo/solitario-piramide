"
Clase abstracta que representa un movimiento reversible en el Solitario de Pirámide (patrón Command).
Cada subclase encapsula la validación, ejecución y reversión (deshacer) de una jugada concreta.
"
Class {
	#name : 'Movimiento',
	#superclass : 'Object',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'operations' }
Movimiento >> deshacerEn: unJuego [
	self subclassResponsibility
]

{ #category : 'operations' }
Movimiento >> ejecutarEn: unJuego [
	self subclassResponsibility
]
