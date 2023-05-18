Class {
	#name : #OpenAPIArraySchemaObject,
	#superclass : #OpenAPISchemaObject,
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #initialization }
OpenAPIArraySchemaObject >> initialize [

	super initialize.
	type := #array
]
