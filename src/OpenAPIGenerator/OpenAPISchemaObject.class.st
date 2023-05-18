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

{ #category : #accessing }
OpenAPISchemaObject class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping | mapping mapInstVars: #( type title description ) ]
]
