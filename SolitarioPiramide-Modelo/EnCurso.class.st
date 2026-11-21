"
Representa el estado de una partida activa de Solitario de Pirámide en la que se pueden realizar movimientos.
"
Class {
	#name : 'EnCurso',
	#superclass : 'EstadoPartida',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'accessing' }
EnCurso >> descripcion [
	^ 'En curso'
]

{ #category : 'testing' }
EnCurso >> permiteMovimientos [
	^ true
]

{ #category : 'operations' }
EnCurso >> validarMovimiento [
	"En curso permite ejecutar movimientos sin señalar error."
]
