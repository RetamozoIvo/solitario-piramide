"
Pruebas unitarias SUnit para la clase TiempoDeJuego.
Verifica la duración por defecto, la duración personalizada, el descuento de segundos y el estado agotado.
"
Class {
	#name : 'TiempoDeJuegoTest',
	#superclass : 'TestCase',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'tests' }
TiempoDeJuegoTest >> testDescontarHastaAgotar [
	| tiempo |
	tiempo := TiempoDeJuego conDuracion: 60.

	self assert: tiempo duracion equals: 60.
	self assert: tiempo tiempoRestante equals: 60.
	self deny: tiempo estaAgotado.

	tiempo descontar: 25.
	self assert: tiempo tiempoRestante equals: 35.
	self deny: tiempo estaAgotado.

	tiempo descontar: 50.
	self assert: tiempo tiempoRestante equals: 0.
	self assert: tiempo estaAgotado
]

{ #category : 'tests' }
TiempoDeJuegoTest >> testDuracionPorDefecto [
	| tiempo |
	tiempo := TiempoDeJuego new.

	self assert: tiempo duracion equals: 300.
	self assert: tiempo tiempoRestante equals: 300.
	self deny: tiempo estaAgotado
]

{ #category : 'tests' }
TiempoDeJuegoTest >> testValoresNegativosInvalidos [
	| tiempo |
	self should: [ TiempoDeJuego conDuracion: -10 ] raise: Error.

	tiempo := TiempoDeJuego new.
	self should: [ tiempo descontar: -1 ] raise: Error
]
