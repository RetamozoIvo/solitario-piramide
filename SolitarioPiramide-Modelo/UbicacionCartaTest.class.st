"
Pruebas unitarias SUnit para la jerarquía UbicacionCarta (UbicacionPiramide y UbicacionPozo).
Verifica la disponibilidad, consulta, retiro, devolución e igualdad polimórfica de ubicaciones.
"
Class {
	#name : 'UbicacionCartaTest',
	#superclass : 'TestCase',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'tests' }
UbicacionCartaTest >> testUbicacionPiramide [
	| juego ubiLibre ubiCubierta cartaOriginal |
	juego := JuegoSolitario new.
	ubiLibre := UbicacionPiramide fila: 7 posicion: 1.
	ubiCubierta := UbicacionPiramide fila: 1 posicion: 1.

	self assert: ubiLibre equals: (UbicacionPiramide fila: 7 posicion: 1).
	self assert: ubiLibre hash equals: (UbicacionPiramide fila: 7 posicion: 1) hash.
	self deny: (ubiLibre = ubiCubierta).
	self assert: ubiLibre filaAfectada equals: 7.

	self assert: (ubiLibre estaDisponibleEn: juego).
	self deny: (ubiCubierta estaDisponibleEn: juego).

	cartaOriginal := ubiLibre cartaEn: juego.
	self assert: ubiLibre carta equals: cartaOriginal.
	self assert: (ubiLibre retirarDe: juego) equals: cartaOriginal.
	self deny: (ubiLibre estaDisponibleEn: juego).

	ubiLibre devolver: cartaOriginal a: juego.
	self assert: (ubiLibre estaDisponibleEn: juego).
	self assert: (ubiLibre cartaEn: juego) equals: cartaOriginal
]

{ #category : 'tests' }
UbicacionCartaTest >> testUbicacionPozo [
	| juego ubiPozo cartaVisible |
	juego := JuegoSolitario new.
	ubiPozo := UbicacionPozo new.

	self assert: ubiPozo equals: UbicacionPozo new.
	self assert: ubiPozo hash equals: UbicacionPozo new hash.
	self assert: ubiPozo filaAfectada isNil.

	self assert: (ubiPozo estaDisponibleEn: juego).
	cartaVisible := ubiPozo cartaEn: juego.
	self assert: ubiPozo carta equals: cartaVisible.

	self assert: (ubiPozo retirarDe: juego) equals: cartaVisible.
	self deny: (ubiPozo estaDisponibleEn: juego).

	ubiPozo devolver: cartaVisible a: juego.
	self assert: (ubiPozo estaDisponibleEn: juego).
	self assert: (ubiPozo cartaEn: juego) equals: cartaVisible
]
