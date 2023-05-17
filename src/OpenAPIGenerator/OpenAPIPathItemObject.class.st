Class {
	#name : #OpenAPIPathItemObject,
	#superclass : #Object,
	#instVars : [
		'action',
		'operation'
	],
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #accessing }
OpenAPIPathItemObject class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping | 
		mapping mapInstVar: #operation to: #action ]
]

{ #category : #accessing }
OpenAPIPathItemObject >> action [

	^ action
]

{ #category : #accessing }
OpenAPIPathItemObject >> action: anObject [

	action := anObject
]

{ #category : #accessing }
OpenAPIPathItemObject >> operation [

	^ operation
]

{ #category : #accessing }
OpenAPIPathItemObject >> operation: anObject [

	operation := anObject
]
