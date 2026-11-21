"
Pruebas unitarias SUnit para la excepción MovimientoInvalido.
Verifica que hereda de Error y preserva el mensaje descriptivo del motivo.
"
Class {
	#name : 'MovimientoInvalidoTest',
	#superclass : 'TestCase',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'tests' }
MovimientoInvalidoTest >> testSenalarConMotivo [
	| mensajeCapturado |
	self
		should: [ MovimientoInvalido signal: 'La carta está cubierta' ]
		raise: MovimientoInvalido.

	[ MovimientoInvalido signal: 'Las cartas no suman 13' ]
		on: MovimientoInvalido
		do: [ :ex | mensajeCapturado := ex motivo ].

	self assert: mensajeCapturado equals: 'Las cartas no suman 13'
]
