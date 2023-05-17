Class {
	#name : #OpenAPIPathObject,
	#superclass : #Object,
	#instVars : [
		'endpoint',
		'pathItem'
	],
	#category : #OpenAPIGenerator
}

{ #category : #accessing }
OpenAPIPathObject >> endpoint [

	^ endpoint
]

{ #category : #accessing }
OpenAPIPathObject >> endpoint: anObject [

	endpoint := anObject
]

{ #category : #accessing }
OpenAPIPathObject >> pathItem [

	^ pathItem
]

{ #category : #accessing }
OpenAPIPathObject >> pathItem: anObject [

	pathItem := anObject
]
