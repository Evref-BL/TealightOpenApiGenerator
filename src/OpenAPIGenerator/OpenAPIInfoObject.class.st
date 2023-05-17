Class {
	#name : #OpenAPIInfoObject,
	#superclass : #Object,
	#instVars : [
		'title',
		'version',
		'description'
	],
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #accessing }
OpenAPIInfoObject class >> neoJsonMapping: mapper [

	mapper
		for: self
		do: [ :mapping | 
		mapping mapInstVars: #( title version description ) ]
]

{ #category : #accessing }
OpenAPIInfoObject >> description [

	^ description
]

{ #category : #accessing }
OpenAPIInfoObject >> description: anObject [

	description := anObject
]

{ #category : #accessing }
OpenAPIInfoObject >> title [

	^ title
]

{ #category : #accessing }
OpenAPIInfoObject >> title: anObject [

	title := anObject
]

{ #category : #accessing }
OpenAPIInfoObject >> version [

	^ version
]

{ #category : #accessing }
OpenAPIInfoObject >> version: anObject [

	version := anObject
]
