Class {
	#name : #OpenAPIObject,
	#superclass : #Object,
	#instVars : [
		'openapi',
		'info',
		'paths'
	],
	#category : #OpenAPIGenerator
}

{ #category : #accessing }
OpenAPIObject >> addPath: aOpenAPIPathObject [
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
