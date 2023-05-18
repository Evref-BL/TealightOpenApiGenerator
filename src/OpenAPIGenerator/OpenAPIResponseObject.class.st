Class {
	#name : #OpenAPIResponseObject,
	#superclass : #Object,
	#instVars : [
		'description',
		'content'
	],
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #accessing }
OpenAPIResponseObject class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping | mapping mapAllInstVars ]
]

{ #category : #accessing }
OpenAPIResponseObject >> content [

	^ content
]

{ #category : #accessing }
OpenAPIResponseObject >> content: anObject [

	content := anObject
]

{ #category : #accessing }
OpenAPIResponseObject >> description [

	^ description
]

{ #category : #accessing }
OpenAPIResponseObject >> description: anObject [

	description := anObject
]
