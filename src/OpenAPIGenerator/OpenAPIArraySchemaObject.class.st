Class {
	#name : #OpenAPIArraySchemaObject,
	#superclass : #OpenAPISchemaObject,
	#instVars : [
		'items'
	],
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #accessing }
OpenAPIArraySchemaObject class >> neoJsonMapping: mapper [

	super neoJsonMapping: mapper.
	mapper for: self do: [ :mapping | mapping mapInstVars: #( items ) ]
]

{ #category : #initialization }
OpenAPIArraySchemaObject >> initialize [

	super initialize.
	type := #array
]

{ #category : #accessing }
OpenAPIArraySchemaObject >> items [

	^ items
]

{ #category : #accessing }
OpenAPIArraySchemaObject >> items: anObject [

	items := anObject
]
