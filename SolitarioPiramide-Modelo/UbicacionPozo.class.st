"
Representa la ubicación correspondiente a la carta visible en el descarte del pozo auxiliar.
"
Class {
	#name : 'UbicacionPozo',
	#superclass : 'UbicacionCarta',
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'comparing' }
UbicacionPozo >> = otraUbicacion [
	^ self class = otraUbicacion class
]

{ #category : 'accessing' }
UbicacionPozo >> cartaEn: unJuego [
	carta := unJuego cartaPozoVisible.
	^ carta
]

{ #category : 'operations' }
UbicacionPozo >> devolver: unaCarta a: unJuego [
	carta := unaCarta.
	unJuego pozo devolverAlDescarte: unaCarta
]

{ #category : 'testing' }
UbicacionPozo >> estaDisponibleEn: unJuego [
	carta := unJuego cartaPozoVisible.
	^ carta notNil
]

{ #category : 'comparing' }
UbicacionPozo >> hash [
	^ self class hash
]

{ #category : 'operations' }
UbicacionPozo >> retirarDe: unJuego [
	carta := unJuego pozo retirarVisible.
	^ carta
]
