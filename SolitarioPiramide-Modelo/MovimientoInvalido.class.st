"
Excepción controlada del dominio que se señala cuando se intenta realizar una jugada inválida
en el Solitario de Pirámide (por ejemplo, carta cubierta, cartas que no suman 13, reserva vacía o partida terminada).
"
Class {
	#name : 'MovimientoInvalido',
	#superclass : 'Error',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'accessing' }
MovimientoInvalido >> motivo [
	^ self messageText
]
