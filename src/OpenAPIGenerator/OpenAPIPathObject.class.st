Class {
	#name : #OpenAPIPathObject,
	#superclass : #Object,
	#instVars : [
		'pathItems'
	],
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #accessing }
OpenAPIPathObject class >> neoJsonMapping: mapper [

	"mapper for: self do: [ :mapping | 
		mapping mapInstVars: #( pathItems ) ]"

	mapper for: self customDo: [ :mapping | 
		mapping encoder: [ :apiPathObjects | 
			| dic |
			dic := Dictionary new.
			apiPathObjects do: [ :apiPathObject | 
				dic addAll: apiPathObject pathItems ].
			dic ] ]
]

{ #category : #accessing }
OpenAPIPathObject >> at: aPath put: aPathItem [

	pathItems at: aPath put: aPathItem
]

{ #category : #accessing }
OpenAPIPathObject >> initialize [

	super initialize.
	pathItems := Dictionary new
]

{ #category : #accessing }
OpenAPIPathObject >> pathItems [

	^ pathItems
]

{ #category : #accessing }
OpenAPIPathObject >> pathItems: anObject [

	pathItems := anObject
]
