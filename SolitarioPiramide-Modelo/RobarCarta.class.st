"
Movimiento concreto que roba la carta superior de la reserva del pozo hacia el descarte
y permite deshacer devolviéndola al tope de la reserva.
"
Class {
	#name : 'RobarCarta',
	#superclass : 'Movimiento',
	#instVars : [
		'cartaRobada'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'accessing' }
RobarCarta >> cartaRobada [
	^ cartaRobada
]

{ #category : 'operations' }
RobarCarta >> deshacerEn: unJuego [
	unJuego pozo deshacerRobar
]

{ #category : 'operations' }
RobarCarta >> ejecutarEn: unJuego [
	unJuego pozo puedeRobar ifFalse: [
		MovimientoInvalido signal: 'No quedan cartas en la reserva para robar' ].
	cartaRobada := unJuego pozo robar
]
