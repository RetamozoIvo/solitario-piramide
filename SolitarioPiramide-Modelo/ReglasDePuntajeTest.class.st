"
Pruebas unitarias SUnit para la clase ReglasDePuntaje.
Verifica las constantes de puntuación y el cálculo del bonus por victoria.
"
Class {
	#name : 'ReglasDePuntajeTest',
	#superclass : 'TestCase',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'tests' }
ReglasDePuntajeTest >> testConstantesDePuntaje [
	self assert: ReglasDePuntaje puntosPorPar equals: 10.
	self assert: ReglasDePuntaje puntosPorRey equals: 5.
	self assert: ReglasDePuntaje puntosPorFilaCompleta equals: 15.
	self assert: ReglasDePuntaje bonusBasePorGanar equals: 100.
	self assert: ReglasDePuntaje duracionPorDefecto equals: 300.
	self assert: (ReglasDePuntaje bonusPorGanarConTiempoRestante: 120) equals: 220
]
