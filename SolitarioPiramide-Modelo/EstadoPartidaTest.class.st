"
Pruebas unitarias SUnit para la jerarquía EstadoPartida (EnCurso, Ganada y Perdida).
Verifica el comportamiento polimórfico de permiteMovimientos, descripcion y validarMovimiento.
"
Class {
	#name : 'EstadoPartidaTest',
	#superclass : 'TestCase',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'tests' }
EstadoPartidaTest >> testEnCurso [
	| estado |
	estado := EnCurso new.

	self assert: estado permiteMovimientos.
	self deny: estado estaTerminada.
	self deny: estado esGanada.
	self deny: estado esPerdida.
	self assert: estado descripcion equals: 'En curso'.
	estado validarMovimiento
]

{ #category : 'tests' }
EstadoPartidaTest >> testGanada [
	| estado |
	estado := Ganada new.

	self deny: estado permiteMovimientos.
	self assert: estado estaTerminada.
	self assert: estado esGanada.
	self deny: estado esPerdida.
	self assert: estado descripcion equals: 'Ganada'.
	self should: [ estado validarMovimiento ] raise: MovimientoInvalido
]

{ #category : 'tests' }
EstadoPartidaTest >> testPerdida [
	| porTiempo porJugadas |
	porTiempo := Perdida tiempoAgotado.
	porJugadas := Perdida sinJugadas.

	self deny: porTiempo permiteMovimientos.
	self assert: porTiempo estaTerminada.
	self deny: porTiempo esGanada.
	self assert: porTiempo esPerdida.
	self assert: porTiempo motivo equals: 'Tiempo agotado'.
	self assert: porTiempo descripcion equals: 'Perdida: Tiempo agotado'.
	self should: [ porTiempo validarMovimiento ] raise: MovimientoInvalido.

	self assert: porJugadas esPerdida.
	self assert: porJugadas motivo equals: 'Sin jugadas disponibles'.
	self assert: porJugadas descripcion equals: 'Perdida: Sin jugadas disponibles'.
	self should: [ porJugadas validarMovimiento ] raise: MovimientoInvalido
]
