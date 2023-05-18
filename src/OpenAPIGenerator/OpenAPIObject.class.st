Class {
	#name : #OpenAPIObject,
	#superclass : #Object,
	#instVars : [
		'openapi',
		'info',
		'paths',
		'servers'
	],
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #accessing }
OpenAPIObject class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping | 
		mapping mapInstVars: #( openapi servers ).
		(mapping mapInstVar: #info) valueSchema: OpenAPIInfoObject.
		(mapping mapInstVar: #paths) valueSchema: OpenAPIPathObject ]
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
	servers := OrderedCollection new
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

{ #category : #accessing }
OpenAPIObject >> servers [

	^ servers
]

{ #category : #accessing }
OpenAPIObject >> servers: anObject [

	servers := anObject
]
