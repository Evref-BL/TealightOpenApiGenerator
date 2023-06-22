Class {
	#name : #OpenAPIBooleanSchemaObject,
	#superclass : #OpenAPISchemaObject,
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #initialization }
OpenAPIBooleanSchemaObject >> initialize [

	super initialize.
	type := 'boolean'
]
