Class {
	#name : #OpenAPIStringSchemaObject,
	#superclass : #OpenAPISchemaObject,
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #initialization }
OpenAPIStringSchemaObject >> initialize [

	super initialize.
	type := 'string'
]
