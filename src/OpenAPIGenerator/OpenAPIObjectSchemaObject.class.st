Class {
	#name : #OpenAPIObjectSchemaObject,
	#superclass : #OpenAPISchemaObject,
	#instVars : [
		'properties'
	],
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #accessing }
OpenAPIObjectSchemaObject class >> neoJsonMapping: mapper [

	super neoJsonMapping: mapper.
	mapper
		for: self
		do: [ :mapping | mapping mapInstVars: #( properties ) ]
]

{ #category : #initialization }
OpenAPIObjectSchemaObject >> initialize [

	super initialize.
	type := 'object'.
	properties := Dictionary new
]

{ #category : #accessing }
OpenAPIObjectSchemaObject >> properties [

	^ properties
]

{ #category : #accessing }
OpenAPIObjectSchemaObject >> properties: anObject [

	properties := anObject
]

{ #category : #accessing }
OpenAPIObjectSchemaObject >> propertyAt: propertyName [

	^ properties at: propertyName
]

{ #category : #accessing }
OpenAPIObjectSchemaObject >> propertyAt: propertyName put: aSchemaObject [

	^ properties at: propertyName put: aSchemaObject
]
