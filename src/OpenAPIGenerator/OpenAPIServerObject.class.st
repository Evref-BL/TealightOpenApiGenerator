Class {
	#name : #OpenAPIServerObject,
	#superclass : #Object,
	#instVars : [
		'url',
		'description'
	],
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #accessing }
OpenAPIServerObject class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping | mapping mapAllInstVars ]
]

{ #category : #accessing }
OpenAPIServerObject >> description [

	^ description
]

{ #category : #accessing }
OpenAPIServerObject >> description: anObject [

	description := anObject
]

{ #category : #accessing }
OpenAPIServerObject >> url [

	^ url
]

{ #category : #accessing }
OpenAPIServerObject >> url: anObject [

	url := anObject
]
