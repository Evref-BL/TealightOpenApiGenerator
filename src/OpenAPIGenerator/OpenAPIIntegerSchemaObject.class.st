Class {
	#name : #OpenAPIIntegerSchemaObject,
	#superclass : #OpenAPISchemaObject,
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #initialization }
OpenAPIIntegerSchemaObject >> initialize [

	super initialize.
	type := 'integer'
]
