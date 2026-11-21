"
Movimiento concreto que elimina un par de cartas disponibles cuyos valores suman 13,
calculando el puntaje por par y por filas completadas, y permitiendo revertirlo con deshacer.
"
Class {
	#name : 'EliminarPar',
	#superclass : 'Movimiento',
	#instVars : [
		'ubicacionA',
		'ubicacionB',
		'cartaA',
		'cartaB',
		'puntosGanados'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'instance creation' }
EliminarPar class >> en: unaUbicacionA y: unaUbicacionB [
	^ self basicNew initializeEn: unaUbicacionA y: unaUbicacionB
]

{ #category : 'operations' }
EliminarPar >> deshacerEn: unJuego [
	ubicacionB devolver: cartaB a: unJuego.
	ubicacionA devolver: cartaA a: unJuego.
	unJuego sumarPuntos: puntosGanados negated
]

{ #category : 'operations' }
EliminarPar >> ejecutarEn: unJuego [
	| primera segunda filasAfectadas |
	ubicacionA = ubicacionB ifTrue: [
		MovimientoInvalido signal: 'Debe seleccionar dos cartas distintas para formar un par' ].

	primera := ubicacionA cartaEn: unJuego.
	primera ifNil: [
		MovimientoInvalido signal: 'No hay ninguna carta en la primera ubicación seleccionada' ].
	(ubicacionA estaDisponibleEn: unJuego) ifFalse: [
		MovimientoInvalido signal: 'La primera carta está cubierta y no se puede jugar' ].

	segunda := ubicacionB cartaEn: unJuego.
	segunda ifNil: [
		MovimientoInvalido signal: 'No hay ninguna carta en la segunda ubicación seleccionada' ].
	(ubicacionB estaDisponibleEn: unJuego) ifFalse: [
		MovimientoInvalido signal: 'La segunda carta está cubierta y no se puede jugar' ].

	(primera suma13Con: segunda) ifFalse: [
		MovimientoInvalido signal: 'Las cartas seleccionadas no suman 13' ].

	filasAfectadas := Set new.
	ubicacionA filaAfectada ifNotNil: [ :unaFila | filasAfectadas add: unaFila ].
	ubicacionB filaAfectada ifNotNil: [ :unaFila | filasAfectadas add: unaFila ].

	cartaA := ubicacionA retirarDe: unJuego.
	cartaB := ubicacionB retirarDe: unJuego.

	puntosGanados := ReglasDePuntaje puntosPorPar.
	filasAfectadas do: [ :unaFila |
		(unJuego piramide estaVaciaLaFila: unaFila) ifTrue: [
			puntosGanados := puntosGanados + ReglasDePuntaje puntosPorFilaCompleta ] ].
	unJuego sumarPuntos: puntosGanados
]

{ #category : 'initialization' }
EliminarPar >> initializeEn: unaUbicacionA y: unaUbicacionB [
	super initialize.
	ubicacionA := unaUbicacionA.
	ubicacionB := unaUbicacionB.
	puntosGanados := 0
]
