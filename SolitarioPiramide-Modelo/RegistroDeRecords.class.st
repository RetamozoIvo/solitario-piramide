"
Administra el mejor puntaje registrado (récord) del Solitario de Pirámide.
Funciona en memoria con #new y opcionalmente persiste en un archivo de texto (por defecto en FileLocator imageDirectory) mediante #conArchivo: o #conArchivoPorDefecto.
"
Class {
	#name : 'RegistroDeRecords',
	#superclass : 'Object',
	#instVars : [
		'mejorPuntaje',
		'archivo'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'accessing' }
RegistroDeRecords class >> archivoPorDefecto [
	^ FileLocator imageDirectory / 'solitario-piramide-record.txt'
]

{ #category : 'instance creation' }
RegistroDeRecords class >> conArchivo: unaReferenciaDeArchivo [
	^ self basicNew initializeConArchivo: unaReferenciaDeArchivo
]

{ #category : 'instance creation' }
RegistroDeRecords class >> conArchivoPorDefecto [
	^ self conArchivo: self archivoPorDefecto
]

{ #category : 'private' }
RegistroDeRecords >> cargarDesdeArchivo [
	archivo ifNil: [ ^ self ].
	archivo exists ifFalse: [ ^ self ].
	[
		| contenido valorLeido |
		contenido := archivo readStreamDo: [ :stream | stream contents trimBoth ].
		valorLeido := Integer readFrom: contenido readStream ifFail: [ 0 ].
		mejorPuntaje := valorLeido max: 0
	] on: Error do: [ :ex | mejorPuntaje := 0 ]
]

{ #category : 'private' }
RegistroDeRecords >> guardarEnArchivo [
	archivo ifNil: [ ^ self ].
	[
		archivo ensureDelete.
		archivo writeStreamDo: [ :stream | stream nextPutAll: mejorPuntaje asString ]
	] on: Error do: [ :ex | ]
]

{ #category : 'initialization' }
RegistroDeRecords >> initialize [
	super initialize.
	mejorPuntaje := 0.
	archivo := nil
]

{ #category : 'initialization' }
RegistroDeRecords >> initializeConArchivo: unaReferenciaDeArchivo [
	super initialize.
	mejorPuntaje := 0.
	archivo := unaReferenciaDeArchivo.
	self cargarDesdeArchivo
]

{ #category : 'accessing' }
RegistroDeRecords >> mejorPuntaje [
	^ mejorPuntaje
]

{ #category : 'operations' }
RegistroDeRecords >> registrarPuntaje: unPuntaje [
	unPuntaje > mejorPuntaje ifTrue: [
		mejorPuntaje := unPuntaje.
		self guardarEnArchivo.
		^ true ].
	^ false
]

{ #category : 'operations' }
RegistroDeRecords >> reiniciar [
	mejorPuntaje := 0.
	archivo ifNotNil: [ [ archivo ensureDelete ] on: Error do: [ :ex | ] ]
]
