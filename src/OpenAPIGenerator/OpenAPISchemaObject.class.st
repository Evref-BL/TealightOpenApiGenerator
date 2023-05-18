Class {
	#name : #OpenAPISchemaObject,
	#superclass : #Object,
	#instVars : [
		'type',
		'title',
		'description'
	],
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #'instance creation' }
OpenAPISchemaObject class >> for: aSchemaTypeString [

	aSchemaTypeString = #string ifTrue: [ 
		^ OpenAPIStringSchemaObject new ].
	aSchemaTypeString = #integer ifTrue: [ 
		^ OpenAPIIntegerSchemaObject new ].
	aSchemaTypeString = #array ifTrue: [ ^ OpenAPIArraySchemaObject new ].
	^ OpenAPIObjectSchemaObject new
]

{ #category : #accessing }
OpenAPISchemaObject class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping | mapping mapInstVars: #( type title description ) ]
]
