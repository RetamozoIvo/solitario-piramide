"
Pruebas unitarias SUnit para la clase RegistroDeRecords.
Verifica la actualización del mejor puntaje en memoria y la persistencia opcional en archivo de texto.
"
Class {
	#name : 'RegistroDeRecordsTest',
	#superclass : 'TestCase',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'tests' }
RegistroDeRecordsTest >> testActualizaSoloSiSuperaAnterior [
	| registro |
	registro := RegistroDeRecords new.

	self assert: registro mejorPuntaje equals: 0.
	self assert: (registro registrarPuntaje: 50).
	self assert: registro mejorPuntaje equals: 50.

	self deny: (registro registrarPuntaje: 50).
	self deny: (registro registrarPuntaje: 30).
	self assert: registro mejorPuntaje equals: 50.

	self assert: (registro registrarPuntaje: 120).
	self assert: registro mejorPuntaje equals: 120
]

{ #category : 'tests' }
RegistroDeRecordsTest >> testPersistenciaEnArchivo [
	| archivoTemporal registro1 registro2 |
	archivoTemporal := FileLocator temp / 'solitario-piramide-record-test.txt'.
	[
		archivoTemporal ensureDelete.
		registro1 := RegistroDeRecords conArchivo: archivoTemporal.
		self assert: registro1 mejorPuntaje equals: 0.

		registro1 registrarPuntaje: 275.
		registro1 registrarPuntaje: 100.

		registro2 := RegistroDeRecords conArchivo: archivoTemporal.
		self assert: registro2 mejorPuntaje equals: 275
	] ensure: [ archivoTemporal ensureDelete ]
]
