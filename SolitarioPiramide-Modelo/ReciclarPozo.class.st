"
Movimiento concreto que recicla todas las cartas del descarte del pozo de vuelta a la reserva y las mezcla,
permitiendo revertir la operación mediante deshacer restaurando el descarte anterior.
"
Class {
	#name : 'ReciclarPozo',
	#superclass : 'Movimiento',
	#instVars : [
		'descarteAnterior'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'operations' }
ReciclarPozo >> deshacerEn: unJuego [
	unJuego pozo restaurarDescarte: descarteAnterior
]

{ #category : 'operations' }
ReciclarPozo >> ejecutarEn: unJuego [
	unJuego pozo puedeReciclar ifFalse: [
		MovimientoInvalido signal: 'Solo se puede mezclar el pozo cuando la reserva está vacía y hay cartas en el descarte' ].
	descarteAnterior := unJuego pozo descarte.
	unJuego pozo reciclar
]
