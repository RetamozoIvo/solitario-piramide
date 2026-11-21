"
Centraliza las constantes de puntuación y configuración de reglas del Solitario de Pirámide
en métodos de clase para facilitar su lectura y eventual modificación.
"
Class {
	#name : 'ReglasDePuntaje',
	#superclass : 'Object',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'accessing' }
ReglasDePuntaje class >> bonusBasePorGanar [
	^ 100
]

{ #category : 'operations' }
ReglasDePuntaje class >> bonusPorGanarConTiempoRestante: unosSegundos [
	^ self bonusBasePorGanar + unosSegundos
]

{ #category : 'accessing' }
ReglasDePuntaje class >> duracionPorDefecto [
	^ 300
]

{ #category : 'accessing' }
ReglasDePuntaje class >> puntosPorFilaCompleta [
	^ 15
]

{ #category : 'accessing' }
ReglasDePuntaje class >> puntosPorPar [
	^ 10
]

{ #category : 'accessing' }
ReglasDePuntaje class >> puntosPorRey [
	^ 5
]
