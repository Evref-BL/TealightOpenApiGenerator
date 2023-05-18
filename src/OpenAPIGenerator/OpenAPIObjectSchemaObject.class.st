Class {
	#name : #OpenAPIObjectSchemaObject,
	#superclass : #OpenAPISchemaObject,
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #initialization }
OpenAPIObjectSchemaObject >> initialize [

	super initialize.
	type := 'object'
]
