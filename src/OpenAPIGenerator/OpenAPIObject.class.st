Class {
	#name : #OpenAPIObject,
	#superclass : #Object,
	#instVars : [
		'openapi',
		'info',
		'paths'
	],
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #accessing }
OpenAPIObject class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping | 
		mapping mapInstVars: #( openapi ).
		(mapping mapInstVar: #info) valueSchema: OpenAPIInfoObject.
		(mapping mapInstVar: #paths) valueSchema: #ArrayOfPath ].
	mapper
		for: #ArrayOfPath
		customDo: [ :mapping | 
		mapping listOfElementSchema: OpenAPIPathObject ]
]

{ #category : #accessing }
OpenAPIObject >> addPath: aOpenAPIPathObject [

	self paths add: aOpenAPIPathObject
]

{ #category : #accessing }
OpenAPIObject >> info [

	^ info
]

{ #category : #accessing }
OpenAPIObject >> info: anObject [

	info := anObject
]

{ #category : #accessing }
OpenAPIObject >> initialize [
	super initialize.
	paths := OrderedCollection new.
]

{ #category : #accessing }
OpenAPIObject >> openapi [

	^ openapi
]

{ #category : #accessing }
OpenAPIObject >> openapi: anObject [

	openapi := anObject
]

{ #category : #accessing }
OpenAPIObject >> paths [

	^ paths
]

{ #category : #accessing }
OpenAPIObject >> paths: anObject [

	paths := anObject
]