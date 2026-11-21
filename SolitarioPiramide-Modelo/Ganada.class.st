"
Representa el estado final de victoria cuando la pirámide queda completamente vacía.
No permite realizar más movimientos.
"
Class {
	#name : 'Ganada',
	#superclass : 'EstadoPartida',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'accessing' }
Ganada >> descripcion [
	^ 'Ganada'
]

{ #category : 'testing' }
Ganada >> esGanada [
	^ true
]

{ #category : 'testing' }
Ganada >> permiteMovimientos [
	^ false
]

{ #category : 'operations' }
Ganada >> validarMovimiento [
	MovimientoInvalido signal: 'La partida ya fue ganada y no admite más movimientos'
]
