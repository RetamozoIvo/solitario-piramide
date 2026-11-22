"
Coordina el estado y las reglas de una partida de Solitario de Pirámide.
Administra el mazo, la pirámide, el pozo auxiliar, el temporizador lógico, el estado de la partida,
el historial de movimientos para deshacer, el puntaje y el registro de récords.
"
Class {
	#name : 'JuegoSolitario',
	#superclass : 'Object',
	#instVars : [
		'mazo',
		'piramide',
		'pozo',
		'puntaje',
		'tiempo',
		'estado',
		'historial',
		'registroDeRecords'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'instance creation' }
JuegoSolitario class >> conMazo: unMazo duracion: unosSegundos [
	^ self
		conMazo: unMazo
		duracion: unosSegundos
		registroDeRecords: RegistroDeRecords new
]

{ #category : 'instance creation' }
JuegoSolitario class >> conMazo: unMazo duracion: unosSegundos registroDeRecords: unRegistro [
	^ self basicNew
		initializeConMazo: unMazo
		duracion: unosSegundos
		registroDeRecords: unRegistro
]

{ #category : 'instance creation' }
JuegoSolitario class >> conRegistroDeRecords: unRegistro [
	| mazoMezclado |
	mazoMezclado := Mazo new.
	mazoMezclado mezclar.
	^ self
		conMazo: mazoMezclado
		duracion: ReglasDePuntaje duracionPorDefecto
		registroDeRecords: unRegistro
]

{ #category : 'private' }
JuegoSolitario >> actualizarEstado [
	estado permiteMovimientos ifFalse: [ ^ self ].
	piramide estaVacia ifTrue: [
		self sumarPuntos: (ReglasDePuntaje bonusPorGanarConTiempoRestante: self tiempoRestante).
		estado := Ganada new.
		^ self ].
	tiempo estaAgotado ifTrue: [
		estado := Perdida tiempoAgotado.
		^ self ].
	self hayJugadasPosibles ifFalse: [
		estado := Perdida sinJugadas ]
]

{ #category : 'accessing' }
JuegoSolitario >> cartaPozoVisible [
	^ pozo cartaVisible
]

{ #category : 'operations' }
JuegoSolitario >> deshacer [
	| ultimoMovimiento |
	estado validarMovimiento.
	historial isEmpty ifTrue: [
		MovimientoInvalido signal: 'No hay movimientos para deshacer' ].
	ultimoMovimiento := historial removeLast.
	ultimoMovimiento deshacerEn: self
]

{ #category : 'private' }
JuegoSolitario >> ejecutarMovimiento: unMovimiento [
	estado validarMovimiento.
	unMovimiento ejecutarEn: self.
	historial addLast: unMovimiento.
	self actualizarEstado
]

{ #category : 'operations' }
JuegoSolitario >> eliminarParEn: unaUbicacionA y: unaUbicacionB [
	self ejecutarMovimiento: (EliminarPar en: unaUbicacionA y: unaUbicacionB)
]

{ #category : 'operations' }
JuegoSolitario >> eliminarReyEn: unaUbicacion [
	self ejecutarMovimiento: (EliminarRey en: unaUbicacion)
]

{ #category : 'accessing' }
JuegoSolitario >> estado [
	^ estado
]

{ #category : 'testing' }
JuegoSolitario >> hayJugadasPosibles [
	| libresPiramide cartasPozo |
	pozo puedeRobar ifTrue: [ ^ true ].
	libresPiramide := piramide cartasLibres.
	(libresPiramide anySatisfy: [ :unaCarta | unaCarta esRey ]) ifTrue: [ ^ true ].
	1 to: libresPiramide size do: [ :i |
		i + 1 to: libresPiramide size do: [ :j |
			((libresPiramide at: i) suma13Con: (libresPiramide at: j))
				ifTrue: [ ^ true ] ] ].
	cartasPozo := pozo descarte.
	(cartasPozo anySatisfy: [ :unaCarta | unaCarta esRey ]) ifTrue: [ ^ true ].
	^ cartasPozo anySatisfy: [ :cartaPozo |
		libresPiramide anySatisfy: [ :cartaPiramide |
			cartaPiramide suma13Con: cartaPozo ] ]
]

{ #category : 'initialization' }
JuegoSolitario >> initialize [
	| mazoMezclado |
	mazoMezclado := Mazo new.
	mazoMezclado mezclar.
	self
		initializeConMazo: mazoMezclado
		duracion: ReglasDePuntaje duracionPorDefecto
		registroDeRecords: RegistroDeRecords new
]

{ #category : 'initialization' }
JuegoSolitario >> initializeConMazo: unMazo duracion: unosSegundos registroDeRecords: unRegistro [
	super initialize.
	puntaje := 0.
	mazo := unMazo.
	piramide := Piramide new.
	piramide repartirDe: mazo.
	pozo := Pozo conReserva: mazo.
	tiempo := TiempoDeJuego conDuracion: unosSegundos.
	estado := EnCurso new.
	historial := OrderedCollection new.
	registroDeRecords := unRegistro.
	self actualizarEstado
]

{ #category : 'accessing' }
JuegoSolitario >> mazo [
	^ mazo
]

{ #category : 'accessing' }
JuegoSolitario >> mejorPuntaje [
	^ registroDeRecords mejorPuntaje
]

{ #category : 'operations' }
JuegoSolitario >> pasarSegundos: unosSegundos [
	estado permiteMovimientos ifFalse: [ ^ self ].
	tiempo descontar: unosSegundos.
	self actualizarEstado
]

{ #category : 'accessing' }
JuegoSolitario >> piramide [
	^ piramide
]

{ #category : 'accessing' }
JuegoSolitario >> pozo [
	^ pozo
]

{ #category : 'testing' }
JuegoSolitario >> puedeDeshacer [
	^ estado permiteMovimientos and: [ historial isEmpty not ]
]

{ #category : 'accessing' }
JuegoSolitario >> puntaje [
	^ puntaje
]

{ #category : 'operations' }
JuegoSolitario >> reciclarPozo [
	self ejecutarMovimiento: ReciclarPozo new
]

{ #category : 'operations' }
JuegoSolitario >> robarCarta [
	self ejecutarMovimiento: RobarCarta new
]

{ #category : 'operations' }
JuegoSolitario >> sacarCartaDelPozo [
	^ pozo robar
]

{ #category : 'operations' }
JuegoSolitario >> sumarPuntos: unaCantidad [
	puntaje := puntaje + unaCantidad.
	registroDeRecords registrarPuntaje: puntaje
]

{ #category : 'accessing' }
JuegoSolitario >> tiempoRestante [
	^ tiempo tiempoRestante
]
