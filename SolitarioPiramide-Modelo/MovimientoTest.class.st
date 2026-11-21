"
Pruebas unitarias SUnit para la jerarquía Movimiento (EliminarRey, EliminarPar y RobarCarta).
Verifica la ejecución y reversión (patrón Command) de cada tipo de movimiento.
"
Class {
	#name : 'MovimientoTest',
	#superclass : 'TestCase',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'helpers' }
MovimientoTest >> crearJuegoDePrueba [
	| cartas |
	cartas := OrderedCollection new.
	21 timesRepeat: [ cartas add: (Carta palo: 'Picas' valor: 2) ].
	cartas add: (Carta palo: 'Picas' valor: 8).
	cartas add: (Carta palo: 'Corazones' valor: 5).
	cartas add: (Carta palo: 'Diamantes' valor: 13).
	cartas add: (Carta palo: 'Tréboles' valor: 9).
	cartas add: (Carta palo: 'Picas' valor: 3).
	cartas add: (Carta palo: 'Corazones' valor: 3).
	cartas add: (Carta palo: 'Diamantes' valor: 3).
	cartas add: (Carta palo: 'Tréboles' valor: 4).
	cartas add: (Carta palo: 'Diamantes' valor: 10).
	^ JuegoSolitario conMazo: (Mazo conCartas: cartas) duracion: 300
]

{ #category : 'tests' }
MovimientoTest >> testEliminarParEjecutarYDeshacer [
	| juego mov ubiA ubiB |
	juego := self crearJuegoDePrueba.
	ubiA := UbicacionPiramide fila: 7 posicion: 1.
	ubiB := UbicacionPiramide fila: 7 posicion: 2.
	mov := EliminarPar en: ubiA y: ubiB.

	mov ejecutarEn: juego.
	self assert: (juego piramide cartaEnFila: 7 posicion: 1) isNil.
	self assert: (juego piramide cartaEnFila: 7 posicion: 2) isNil.
	self assert: juego puntaje equals: ReglasDePuntaje puntosPorPar.

	mov deshacerEn: juego.
	self assert: (juego piramide cartaEnFila: 7 posicion: 1) equals: (Carta palo: 'Picas' valor: 8).
	self assert: (juego piramide cartaEnFila: 7 posicion: 2) equals: (Carta palo: 'Corazones' valor: 5).
	self assert: juego puntaje equals: 0
]

{ #category : 'tests' }
MovimientoTest >> testEliminarReyEjecutarYDeshacer [
	| juego mov ubi |
	juego := self crearJuegoDePrueba.
	ubi := UbicacionPiramide fila: 7 posicion: 3.
	mov := EliminarRey en: ubi.

	mov ejecutarEn: juego.
	self assert: (juego piramide cartaEnFila: 7 posicion: 3) isNil.
	self assert: juego puntaje equals: ReglasDePuntaje puntosPorRey.

	mov deshacerEn: juego.
	self assert: (juego piramide cartaEnFila: 7 posicion: 3) equals: (Carta palo: 'Diamantes' valor: 13).
	self assert: juego puntaje equals: 0
]

{ #category : 'tests' }
MovimientoTest >> testRobarCartaEjecutarYDeshacer [
	| juego mov visibleAnterior |
	juego := self crearJuegoDePrueba.
	visibleAnterior := juego cartaPozoVisible.
	mov := RobarCarta new.

	mov ejecutarEn: juego.
	self assert: juego cartaPozoVisible equals: (Carta palo: 'Diamantes' valor: 10).
	self deny: juego pozo puedeRobar.

	mov deshacerEn: juego.
	self assert: juego cartaPozoVisible equals: visibleAnterior.
	self assert: juego pozo puedeRobar
]
