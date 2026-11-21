"
Movimiento concreto que elimina un Rey (valor 13) disponible de la pirámide o del pozo,
otorgando los puntos correspondientes (y el bonus por fila completa si aplica) y soportando deshacer.
"
Class {
	#name : 'EliminarRey',
	#superclass : 'Movimiento',
	#instVars : [
		'ubicacion',
		'cartaEliminada',
		'puntosGanados'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'instance creation' }
EliminarRey class >> en: unaUbicacion [
	^ self basicNew initializeEn: unaUbicacion
]

{ #category : 'operations' }
EliminarRey >> deshacerEn: unJuego [
	ubicacion devolver: cartaEliminada a: unJuego.
	unJuego sumarPuntos: puntosGanados negated
]

{ #category : 'operations' }
EliminarRey >> ejecutarEn: unJuego [
	| carta fila |
	carta := ubicacion cartaEn: unJuego.
	carta ifNil: [
		MovimientoInvalido signal: 'No hay ninguna carta en la ubicación seleccionada' ].
	(ubicacion estaDisponibleEn: unJuego) ifFalse: [
		MovimientoInvalido signal: 'La carta está cubierta y no se puede jugar' ].
	carta esRey ifFalse: [
		MovimientoInvalido signal: 'Solo un rey (13) puede eliminarse solo' ].

	fila := ubicacion filaAfectada.
	cartaEliminada := ubicacion retirarDe: unJuego.

	puntosGanados := ReglasDePuntaje puntosPorRey.
	(fila notNil and: [ unJuego piramide estaVaciaLaFila: fila ]) ifTrue: [
		puntosGanados := puntosGanados + ReglasDePuntaje puntosPorFilaCompleta ].
	unJuego sumarPuntos: puntosGanados
]

{ #category : 'initialization' }
EliminarRey >> initializeEn: unaUbicacion [
	super initialize.
	ubicacion := unaUbicacion.
	puntosGanados := 0
]
