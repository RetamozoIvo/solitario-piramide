Class {
	#name : 'Carta',
	#superclass : 'Object',
	#instVars : [
		'palo',
		'valor'
	],
	#category : 'SolitarioPiramide-Modelo',
	#package : 'SolitarioPiramide-Modelo'
}

{ #category : 'as yet unclassified' }
Carta class >> palo: unPalo valor: unValor [
    "Crea una nueva instancia de Carta ya inicializada"
    ^ self new
        palo: unPalo;
        valor: unValor;
        yourself.
]

{ #category : 'as yet unclassified' }
Carta >> esRey [
    "Devuelve true si es un Rey (K), que vale 13 y se elimina solo"
    ^ self valor = 13.
]

{ #category : 'as yet unclassified' }
Carta >> nombreDelValor [
    "Traduce los valores numéricos a sus letras correspondientes para la interfaz/impresión"
    self valor = 1 ifTrue: [ ^ 'A' ].
    self valor = 11 ifTrue: [ ^ 'J' ].
    self valor = 12 ifTrue: [ ^ 'Q' ].
    self valor = 13 ifTrue: [ ^ 'K' ].
    ^ self valor.
]

{ #category : 'accessing' }
Carta >> palo [
    ^ palo
]

{ #category : 'accessing' }
Carta >> palo: unString [
    palo := unString.
]

{ #category : 'printing' }
Carta >> printOn: aStream [
    aStream 
        nextPutAll: self nombreDelValor asString;
        nextPutAll: ' de ';
        nextPutAll: self palo asString.
]

{ #category : 'as yet unclassified' }
Carta >> suma13Con: otraCarta [
    "Recibe otra instancia de Carta y verifica si juntas suman 13"
    ^ (self valor + otraCarta valor) = 13.
]

{ #category : 'accessing' }
Carta >> valor [
    ^ valor
]

{ #category : 'accessing' }
Carta >> valor: unEntero [
    valor := unEntero.
]
