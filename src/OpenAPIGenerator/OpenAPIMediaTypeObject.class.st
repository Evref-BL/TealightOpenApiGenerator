Class {
	#name : #OpenAPIMediaTypeObject,
	#superclass : #Object,
	#instVars : [
		'schema'
	],
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #accessing }
OpenAPIMediaTypeObject class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping | mapping mapAllInstVars ]
]

{ #category : #accessing }
OpenAPIMediaTypeObject >> schema [

	^ schema
]

{ #category : #accessing }
OpenAPIMediaTypeObject >> schema: anObject [

	schema := anObject
]
