"
Pruebas unitarias SUnit para la clase JuegoSolitario.
Verifica la inicialización, jugadas válidas e inválidas, pozo, puntaje (pares, reyes, filas completas y bonus),
temporizador lógico, condiciones de victoria y derrota, deshacer y actualización de récords.
"
Class {
	#name : 'JuegoSolitarioTest',
	#superclass : 'TestCase',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'helpers' }
JuegoSolitarioTest >> mazoConJugadasYPozo [
	| cartas |
	cartas := OrderedCollection new.
	cartas add: (Carta palo: 'Picas' valor: 13).
	20 timesRepeat: [ cartas add: (Carta palo: 'Picas' valor: 2) ].
	cartas add: (Carta palo: 'Picas' valor: 8).
	cartas add: (Carta palo: 'Corazones' valor: 5).
	cartas add: (Carta palo: 'Diamantes' valor: 13).
	cartas add: (Carta palo: 'Tréboles' valor: 9).
	cartas add: (Carta palo: 'Picas' valor: 3).
	cartas add: (Carta palo: 'Corazones' valor: 3).
	cartas add: (Carta palo: 'Diamantes' valor: 3).
	cartas add: (Carta palo: 'Tréboles' valor: 4).
	cartas add: (Carta palo: 'Diamantes' valor: 10).
	^ Mazo conCartas: cartas
]

{ #category : 'helpers' }
JuegoSolitarioTest >> mazoParaGanar [
	| cartas |
	cartas := OrderedCollection new.
	"Fila 1 (1 carta)"
	cartas add: (Carta palo: 'Picas' valor: 13).
	"Fila 2 (2 cartas)"
	cartas add: (Carta palo: 'Picas' valor: 1).
	cartas add: (Carta palo: 'Picas' valor: 12).
	"Fila 3 (3 cartas)"
	cartas add: (Carta palo: 'Corazones' valor: 13).
	cartas add: (Carta palo: 'Picas' valor: 2).
	cartas add: (Carta palo: 'Picas' valor: 11).
	"Fila 4 (4 cartas)"
	cartas add: (Carta palo: 'Picas' valor: 3).
	cartas add: (Carta palo: 'Picas' valor: 10).
	cartas add: (Carta palo: 'Corazones' valor: 1).
	cartas add: (Carta palo: 'Corazones' valor: 12).
	"Fila 5 (5 cartas)"
	cartas add: (Carta palo: 'Diamantes' valor: 13).
	cartas add: (Carta palo: 'Corazones' valor: 2).
	cartas add: (Carta palo: 'Corazones' valor: 11).
	cartas add: (Carta palo: 'Corazones' valor: 3).
	cartas add: (Carta palo: 'Corazones' valor: 10).
	"Fila 6 (6 cartas)"
	cartas add: (Carta palo: 'Diamantes' valor: 1).
	cartas add: (Carta palo: 'Diamantes' valor: 12).
	cartas add: (Carta palo: 'Diamantes' valor: 2).
	cartas add: (Carta palo: 'Diamantes' valor: 11).
	cartas add: (Carta palo: 'Diamantes' valor: 3).
	cartas add: (Carta palo: 'Diamantes' valor: 10).
	"Fila 7 (7 cartas)"
	cartas add: (Carta palo: 'Tréboles' valor: 13).
	cartas add: (Carta palo: 'Tréboles' valor: 1).
	cartas add: (Carta palo: 'Tréboles' valor: 12).
	cartas add: (Carta palo: 'Tréboles' valor: 2).
	cartas add: (Carta palo: 'Tréboles' valor: 11).
	cartas add: (Carta palo: 'Tréboles' valor: 3).
	cartas add: (Carta palo: 'Tréboles' valor: 10).
	^ Mazo conCartas: cartas
]

{ #category : 'tests' }
JuegoSolitarioTest >> testDeshacerTodosLosTiposDeMovimiento [
	| juego |
	juego := JuegoSolitario conMazo: self mazoConJugadasYPozo duracion: 300.

	"1. Eliminar Rey y deshacer"
	juego eliminarReyEn: (UbicacionPiramide fila: 7 posicion: 3).
	self assert: juego puntaje equals: 5.
	self assert: (juego piramide cartaEnFila: 7 posicion: 3) isNil.
	juego deshacer.
	self assert: juego puntaje equals: 0.
	self assert: (juego piramide cartaEnFila: 7 posicion: 3) equals: (Carta palo: 'Diamantes' valor: 13).

	"2. Eliminar Par (pirámide + pozo) y deshacer"
	juego robarCarta.
	self assert: juego cartaPozoVisible equals: (Carta palo: 'Tréboles' valor: 4).
	juego
		eliminarParEn: (UbicacionPiramide fila: 7 posicion: 4)
		y: UbicacionPozo new.
	self assert: juego puntaje equals: 10.
	self assert: (juego piramide cartaEnFila: 7 posicion: 4) isNil.
	self assert: juego cartaPozoVisible isNil.
	juego deshacer.
	self assert: juego puntaje equals: 0.
	self assert: (juego piramide cartaEnFila: 7 posicion: 4) equals: (Carta palo: 'Tréboles' valor: 9).
	self assert: juego cartaPozoVisible equals: (Carta palo: 'Tréboles' valor: 4).

	"3. Robar carta y deshacer"
	juego robarCarta.
	self assert: juego cartaPozoVisible equals: (Carta palo: 'Diamantes' valor: 10).
	self deny: juego pozo puedeRobar.
	juego deshacer.
	self assert: juego cartaPozoVisible equals: (Carta palo: 'Tréboles' valor: 4).
	self assert: juego pozo puedeRobar.

	juego deshacer.
	self assert: juego cartaPozoVisible isNil.
	self assert: juego pozo cantidadEnReserva equals: 2.

	"4. Deshacer con historial vacío señala MovimientoInvalido"
	self should: [ juego deshacer ] raise: MovimientoInvalido
]

{ #category : 'tests' }
JuegoSolitarioTest >> testFinPorFaltaDeJugadas [
	| cartas juego |
	cartas := OrderedCollection new.
	21 timesRepeat: [ cartas add: (Carta palo: 'Picas' valor: 2) ].
	cartas add: (Carta palo: 'Picas' valor: 13).
	6 timesRepeat: [ cartas add: (Carta palo: 'Corazones' valor: 2) ].

	juego := JuegoSolitario conMazo: (Mazo conCartas: cartas) duracion: 300.
	self assert: juego estado permiteMovimientos.
	self assert: juego hayJugadasPosibles.

	juego eliminarReyEn: (UbicacionPiramide fila: 7 posicion: 1).
	self deny: juego hayJugadasPosibles.
	self assert: juego estado esPerdida.
	self assert: juego estado motivo equals: 'Sin jugadas disponibles'.

	self should: [ juego robarCarta ] raise: MovimientoInvalido.
	self should: [ juego deshacer ] raise: MovimientoInvalido
]

{ #category : 'tests' }
JuegoSolitarioTest >> testInicializacion [
	| juego |
	juego := JuegoSolitario new.

	self assert: juego puntaje equals: 0.
	self assert: juego tiempoRestante equals: 300.
	self assert: juego estado permiteMovimientos.
	self assert: juego cartaPozoVisible isNil.
	self assert: juego pozo cantidadEnReserva equals: 24.
	self assert: juego pozo cantidadEnDescarte equals: 0.
	self assert: juego mazo cantidadDeCartas equals: 24.
	self assert: ((juego piramide cartaEnFila: 1 posicion: 1) isKindOf: Carta).
	self assert: ((juego piramide cartaEnFila: 7 posicion: 7) isKindOf: Carta)
]

{ #category : 'tests' }
JuegoSolitarioTest >> testParValidoInvalidoYCubierto [
	| juego |
	juego := JuegoSolitario conMazo: self mazoConJugadasYPozo duracion: 300.

	"Par inválido (8 + 3 = 11) no modifica estado"
	self
		should: [ juego eliminarParEn: (UbicacionPiramide fila: 7 posicion: 1) y: (UbicacionPiramide fila: 7 posicion: 5) ]
		raise: MovimientoInvalido.
	self assert: juego puntaje equals: 0.
	self assert: (juego piramide cartaEnFila: 7 posicion: 1) equals: (Carta palo: 'Picas' valor: 8).

	"Par con carta cubierta no modifica estado"
	self
		should: [ juego eliminarParEn: (UbicacionPiramide fila: 6 posicion: 1) y: (UbicacionPiramide fila: 7 posicion: 1) ]
		raise: MovimientoInvalido.
	self assert: juego puntaje equals: 0.

	"Par válido (8 + 5 = 13) elimina ambas y suma 10 puntos"
	juego
		eliminarParEn: (UbicacionPiramide fila: 7 posicion: 1)
		y: (UbicacionPiramide fila: 7 posicion: 2).
	self assert: juego puntaje equals: ReglasDePuntaje puntosPorPar.
	self assert: (juego piramide cartaEnFila: 7 posicion: 1) isNil.
	self assert: (juego piramide cartaEnFila: 7 posicion: 2) isNil
]

{ #category : 'tests' }
JuegoSolitarioTest >> testPuntajePorFilaCompleta [
	| juego |
	juego := JuegoSolitario conMazo: self mazoParaGanar duracion: 300.

	juego eliminarReyEn: (UbicacionPiramide fila: 7 posicion: 1).
	self assert: juego puntaje equals: 5.

	juego eliminarParEn: (UbicacionPiramide fila: 7 posicion: 2) y: (UbicacionPiramide fila: 7 posicion: 3).
	self assert: juego puntaje equals: 15.

	juego eliminarParEn: (UbicacionPiramide fila: 7 posicion: 4) y: (UbicacionPiramide fila: 7 posicion: 5).
	self assert: juego puntaje equals: 25.

	"Al eliminar el último par de la fila 7 se suman 10 del par + 15 de fila completa"
	juego eliminarParEn: (UbicacionPiramide fila: 7 posicion: 6) y: (UbicacionPiramide fila: 7 posicion: 7).
	self assert: (juego piramide estaVaciaLaFila: 7).
	self assert: juego puntaje equals: 50
]

{ #category : 'tests' }
JuegoSolitarioTest >> testRecordActualizaSoloSiSupera [
	| registro juego1 juego2 |
	registro := RegistroDeRecords new.
	juego1 := JuegoSolitario
		conMazo: self mazoConJugadasYPozo
		duracion: 300
		registroDeRecords: registro.

	juego1 eliminarParEn: (UbicacionPiramide fila: 7 posicion: 1) y: (UbicacionPiramide fila: 7 posicion: 2).
	self assert: juego1 mejorPuntaje equals: 10.

	juego2 := JuegoSolitario
		conMazo: self mazoConJugadasYPozo
		duracion: 300
		registroDeRecords: registro.
	juego2 eliminarReyEn: (UbicacionPiramide fila: 7 posicion: 3).
	self assert: juego2 puntaje equals: 5.
	self assert: juego2 mejorPuntaje equals: 10.

	juego2 eliminarParEn: (UbicacionPiramide fila: 7 posicion: 1) y: (UbicacionPiramide fila: 7 posicion: 2).
	self assert: juego2 puntaje equals: 15.
	self assert: juego2 mejorPuntaje equals: 15
]

{ #category : 'tests' }
JuegoSolitarioTest >> testReyLibreYCubierto [
	| juego |
	juego := JuegoSolitario conMazo: self mazoConJugadasYPozo duracion: 300.

	"Rey cubierto en (1,1) señala MovimientoInvalido y no altera estado"
	self
		should: [ juego eliminarReyEn: (UbicacionPiramide fila: 1 posicion: 1) ]
		raise: MovimientoInvalido.
	self assert: juego puntaje equals: 0.
	self assert: (juego piramide cartaEnFila: 1 posicion: 1) equals: (Carta palo: 'Picas' valor: 13).

	"Carta libre que no es rey señala MovimientoInvalido"
	self
		should: [ juego eliminarReyEn: (UbicacionPiramide fila: 7 posicion: 1) ]
		raise: MovimientoInvalido.
	self assert: juego puntaje equals: 0.

	"Rey libre en (7,3) se elimina y suma 5 puntos"
	juego eliminarReyEn: (UbicacionPiramide fila: 7 posicion: 3).
	self assert: juego puntaje equals: ReglasDePuntaje puntosPorRey.
	self assert: (juego piramide cartaEnFila: 7 posicion: 3) isNil
]

{ #category : 'tests' }
JuegoSolitarioTest >> testSacarCartaDelPozo [
	| juego primeraCarta segundaCarta ultimaCarta |
	juego := JuegoSolitario new.
	self assert: juego cartaPozoVisible isNil.
	self assert: juego mazo cantidadDeCartas equals: 24.

	primeraCarta := juego sacarCartaDelPozo.
	self assert: (primeraCarta isKindOf: Carta).
	self assert: juego cartaPozoVisible equals: primeraCarta.
	self assert: juego mazo cantidadDeCartas equals: 23.

	segundaCarta := juego sacarCartaDelPozo.
	self assert: (segundaCarta isKindOf: Carta).
	self assert: juego cartaPozoVisible equals: segundaCarta.
	self deny: (primeraCarta = segundaCarta).
	self assert: juego mazo cantidadDeCartas equals: 22.

	22 timesRepeat: [
		ultimaCarta := juego sacarCartaDelPozo.
		self assert: (ultimaCarta isKindOf: Carta) ].

	self assert: juego mazo estaVacio.
	self assert: juego sacarCartaDelPozo isNil.
	self assert: juego cartaPozoVisible equals: ultimaCarta
]

{ #category : 'tests' }
JuegoSolitarioTest >> testReciclarPozoYDeshacer [
	| cartas juego cartasRecicladas |
	cartas := OrderedCollection new.
	28 timesRepeat: [ cartas add: (Carta palo: 'Picas' valor: 2) ].
	cartas add: (Carta palo: 'Corazones' valor: 11).
	cartas add: (Carta palo: 'Tréboles' valor: 4).
	juego := JuegoSolitario conMazo: (Mazo conCartas: cartas) duracion: 300.

	"No se puede reciclar mientras queden cartas en la reserva"
	self should: [ juego reciclarPozo ] raise: MovimientoInvalido.

	"Al robar todas las cartas, el 11 en el descarte mantiene jugadas posibles"
	juego robarCarta.
	juego robarCarta.
	self deny: juego pozo puedeRobar.
	self assert: juego pozo puedeReciclar.
	self assert: juego estado permiteMovimientos.
	self assert: juego hayJugadasPosibles.

	"Reciclar devuelve y mezcla el descarte en la reserva"
	juego reciclarPozo.
	self assert: juego pozo puedeRobar.
	self deny: juego pozo puedeReciclar.
	self assert: juego pozo cantidadEnReserva equals: 2.
	self assert: juego mazo cantidadDeCartas equals: 2.
	self assert: juego cartaPozoVisible isNil.

	"Deshacer restaura el descarte anterior"
	juego deshacer.
	self deny: juego pozo puedeRobar.
	self assert: juego pozo puedeReciclar.
	self assert: juego cartaPozoVisible equals: (Carta palo: 'Tréboles' valor: 4).

	"Volver a reciclar permite robar las mismas cartas nuevamente"
	juego reciclarPozo.
	cartasRecicladas := OrderedCollection new.
	2 timesRepeat: [
		juego robarCarta.
		cartasRecicladas add: juego cartaPozoVisible ].
	self
		assert: cartasRecicladas asSet
		equals: { Carta palo: 'Corazones' valor: 11. Carta palo: 'Tréboles' valor: 4 } asSet
]

{ #category : 'tests' }
JuegoSolitarioTest >> testSumarPuntos [
	| juego |
	juego := JuegoSolitario new.

	self assert: juego puntaje equals: 0.

	juego sumarPuntos: 10.
	self assert: juego puntaje equals: 10.

	juego sumarPuntos: 25.
	self assert: juego puntaje equals: 35
]

{ #category : 'tests' }
JuegoSolitarioTest >> testTiempoAgotadoPasaAPerdidaYBloqueaMovimientos [
	| juego |
	juego := JuegoSolitario conMazo: self mazoConJugadasYPozo duracion: 30.

	juego pasarSegundos: 10.
	self assert: juego tiempoRestante equals: 20.
	self assert: juego estado permiteMovimientos.

	juego pasarSegundos: 20.
	self assert: juego tiempoRestante equals: 0.
	self assert: juego estado esPerdida.
	self assert: juego estado motivo equals: 'Tiempo agotado'.

	self
		should: [ juego eliminarReyEn: (UbicacionPiramide fila: 7 posicion: 3) ]
		raise: MovimientoInvalido.
	self should: [ juego robarCarta ] raise: MovimientoInvalido
]

{ #category : 'tests' }
JuegoSolitarioTest >> testVictoriaCompletaYBonus [
	| juego |
	juego := JuegoSolitario conMazo: self mazoParaGanar duracion: 200.
	juego pasarSegundos: 50.

	"Fila 7"
	juego eliminarReyEn: (UbicacionPiramide fila: 7 posicion: 1).
	juego eliminarParEn: (UbicacionPiramide fila: 7 posicion: 2) y: (UbicacionPiramide fila: 7 posicion: 3).
	juego eliminarParEn: (UbicacionPiramide fila: 7 posicion: 4) y: (UbicacionPiramide fila: 7 posicion: 5).
	juego eliminarParEn: (UbicacionPiramide fila: 7 posicion: 6) y: (UbicacionPiramide fila: 7 posicion: 7).
	"Fila 6"
	juego eliminarParEn: (UbicacionPiramide fila: 6 posicion: 1) y: (UbicacionPiramide fila: 6 posicion: 2).
	juego eliminarParEn: (UbicacionPiramide fila: 6 posicion: 3) y: (UbicacionPiramide fila: 6 posicion: 4).
	juego eliminarParEn: (UbicacionPiramide fila: 6 posicion: 5) y: (UbicacionPiramide fila: 6 posicion: 6).
	"Fila 5"
	juego eliminarReyEn: (UbicacionPiramide fila: 5 posicion: 1).
	juego eliminarParEn: (UbicacionPiramide fila: 5 posicion: 2) y: (UbicacionPiramide fila: 5 posicion: 3).
	juego eliminarParEn: (UbicacionPiramide fila: 5 posicion: 4) y: (UbicacionPiramide fila: 5 posicion: 5).
	"Fila 4"
	juego eliminarParEn: (UbicacionPiramide fila: 4 posicion: 1) y: (UbicacionPiramide fila: 4 posicion: 2).
	juego eliminarParEn: (UbicacionPiramide fila: 4 posicion: 3) y: (UbicacionPiramide fila: 4 posicion: 4).
	"Fila 3"
	juego eliminarReyEn: (UbicacionPiramide fila: 3 posicion: 1).
	juego eliminarParEn: (UbicacionPiramide fila: 3 posicion: 2) y: (UbicacionPiramide fila: 3 posicion: 3).
	"Fila 2"
	juego eliminarParEn: (UbicacionPiramide fila: 2 posicion: 1) y: (UbicacionPiramide fila: 2 posicion: 2).
	"Fila 1"
	juego eliminarReyEn: (UbicacionPiramide fila: 1 posicion: 1).

	self assert: juego piramide estaVacia.
	self assert: juego estado esGanada.
	self deny: juego estado permiteMovimientos.
	"4 reyes (20) + 12 pares (120) + 7 filas (105) + bonus (100 + 150) = 495"
	self assert: juego puntaje equals: 495.
	self assert: juego mejorPuntaje equals: 495.

	"Tras ganar, el tiempo queda congelado y no se aceptan movimientos"
	juego pasarSegundos: 30.
	self assert: juego tiempoRestante equals: 150.
	self should: [ juego deshacer ] raise: MovimientoInvalido.
	self should: [ juego robarCarta ] raise: MovimientoInvalido
]
