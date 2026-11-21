"
Representa el estado final de derrota de una partida de Solitario de Pirámide, junto con el motivo
(tiempo agotado o falta de jugadas disponibles). No permite realizar más movimientos.
"
Class {
	#name : 'Perdida',
	#superclass : 'EstadoPartida',
	#instVars : [
		'motivo'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'instance creation' }
Perdida class >> conMotivo: unMotivo [
	^ self basicNew initializeConMotivo: unMotivo
]

{ #category : 'instance creation' }
Perdida class >> sinJugadas [
	^ self conMotivo: 'Sin jugadas disponibles'
]

{ #category : 'instance creation' }
Perdida class >> tiempoAgotado [
	^ self conMotivo: 'Tiempo agotado'
]

{ #category : 'accessing' }
Perdida >> descripcion [
	^ 'Perdida: ' , motivo
]

{ #category : 'testing' }
Perdida >> esPerdida [
	^ true
]

{ #category : 'initialization' }
Perdida >> initializeConMotivo: unMotivo [
	super initialize.
	motivo := unMotivo
]

{ #category : 'accessing' }
Perdida >> motivo [
	^ motivo
]

{ #category : 'testing' }
Perdida >> permiteMovimientos [
	^ false
]

{ #category : 'operations' }
Perdida >> validarMovimiento [
	MovimientoInvalido signal: 'La partida terminó (' , motivo , ') y no admite más movimientos'
]
