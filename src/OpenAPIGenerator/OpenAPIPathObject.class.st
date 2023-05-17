Class {
	#name : #OpenAPIPathObject,
	#superclass : #Object,
	#instVars : [
		'endpoint',
		'pathItems'
	],
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #accessing }
OpenAPIPathObject class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping |
		mapping mapInstVar: #pathItems to: #endpoint
		 ]
]

{ #category : #accessing }
OpenAPIPathObject >> addPathItem: aPathItem [
	pathItems add: aPathItem 
]

{ #category : #accessing }
OpenAPIPathObject >> endpoint [

	^ endpoint
]

{ #category : #accessing }
OpenAPIPathObject >> endpoint: anObject [

	endpoint := anObject
]

{ #category : #accessing }
OpenAPIPathObject >> initialize [

	super initialize.
	pathItems := OrderedCollection new
]

{ #category : #accessing }
OpenAPIPathObject >> pathItems [

	^ pathItems
]

{ #category : #accessing }
OpenAPIPathObject >> pathItems: anObject [

	pathItems := anObject
]
