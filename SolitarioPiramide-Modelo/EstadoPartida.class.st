"
Clase abstracta que modela el estado actual de una partida de Solitario de Pirámide (patrón State).
Permite decidir polimórficamente si se aceptan movimientos y obtener una descripción legible del estado.
"
Class {
	#name : 'EstadoPartida',
	#superclass : 'Object',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'accessing' }
EstadoPartida >> descripcion [
	self subclassResponsibility
]

{ #category : 'testing' }
EstadoPartida >> esGanada [
	^ false
]

{ #category : 'testing' }
EstadoPartida >> esPerdida [
	^ false
]

{ #category : 'testing' }
EstadoPartida >> estaTerminada [
	^ self permiteMovimientos not
]

{ #category : 'testing' }
EstadoPartida >> permiteMovimientos [
	self subclassResponsibility
]

{ #category : 'operations' }
EstadoPartida >> validarMovimiento [
	self subclassResponsibility
]
