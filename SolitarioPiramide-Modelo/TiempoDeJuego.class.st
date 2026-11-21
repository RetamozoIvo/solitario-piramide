"
Administra el temporizador lógico de una partida de Solitario de Pirámide sin depender del reloj real.
Permite configurar una duración inicial, descontar segundos y consultar si el tiempo se agotó.
"
Class {
	#name : 'TiempoDeJuego',
	#superclass : 'Object',
	#instVars : [
		'duracion',
		'tiempoRestante'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'instance creation' }
TiempoDeJuego class >> conDuracion: unosSegundos [
	^ self basicNew initializeConDuracion: unosSegundos
]

{ #category : 'operations' }
TiempoDeJuego >> descontar: unosSegundos [
	unosSegundos < 0 ifTrue: [
		self error: 'Los segundos a descontar no pueden ser negativos' ].
	tiempoRestante := (tiempoRestante - unosSegundos) max: 0
]

{ #category : 'accessing' }
TiempoDeJuego >> duracion [
	^ duracion
]

{ #category : 'testing' }
TiempoDeJuego >> estaAgotado [
	^ tiempoRestante <= 0
]

{ #category : 'initialization' }
TiempoDeJuego >> initialize [
	self initializeConDuracion: ReglasDePuntaje duracionPorDefecto
]

{ #category : 'initialization' }
TiempoDeJuego >> initializeConDuracion: unosSegundos [
	super initialize.
	unosSegundos < 0 ifTrue: [
		self error: 'La duración no puede ser negativa' ].
	duracion := unosSegundos.
	tiempoRestante := unosSegundos
]

{ #category : 'accessing' }
TiempoDeJuego >> tiempoRestante [
	^ tiempoRestante
]
