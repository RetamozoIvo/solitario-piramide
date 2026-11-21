"
Clase abstracta que representa la ubicación lógica de una carta dentro de una partida
(ya sea en la pirámide o en la carta visible del pozo).
Permite consultar disponibilidad, obtener, retirar y devolver cartas de forma polimórfica.
"
Class {
	#name : 'UbicacionCarta',
	#superclass : 'Object',
	#instVars : [
		'carta'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'accessing' }
UbicacionCarta >> carta [
	^ carta
]

{ #category : 'accessing' }
UbicacionCarta >> cartaEn: unJuego [
	self subclassResponsibility
]

{ #category : 'operations' }
UbicacionCarta >> devolver: unaCarta a: unJuego [
	self subclassResponsibility
]

{ #category : 'testing' }
UbicacionCarta >> estaDisponibleEn: unJuego [
	self subclassResponsibility
]

{ #category : 'accessing' }
UbicacionCarta >> filaAfectada [
	^ nil
]

{ #category : 'operations' }
UbicacionCarta >> retirarDe: unJuego [
	self subclassResponsibility
]
