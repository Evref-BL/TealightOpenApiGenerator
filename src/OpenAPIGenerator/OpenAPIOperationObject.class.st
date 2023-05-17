Class {
	#name : #OpenAPIOperationObject,
	#superclass : #Object,
	#instVars : [
		'summary',
		'description',
		'requestBody',
		'responses',
		'operationId',
		'parameters'
	],
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #accessing }
OpenAPIOperationObject class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping | 
		mapping mapInstVars: #( summary description operationId ).
		(mapping mapInstVar: #parameters) valueSchema: #ArrayOfParameter ].
	mapper
		for: #ArrayOfParameter
		customDo: [ :mapping | 
		mapping listOfElementSchema: OpenAPIParameterObject ]
]

{ #category : #accessing }
OpenAPIOperationObject >> addParameter: aParameterObject [

	parameters add: aParameterObject
]

{ #category : #accessing }
OpenAPIOperationObject >> description [

	^ description
]

{ #category : #accessing }
OpenAPIOperationObject >> description: anObject [

	description := anObject
]

{ #category : #accessing }
OpenAPIOperationObject >> initialize [

	super initialize.
	parameters := OrderedCollection new
]

{ #category : #accessing }
OpenAPIOperationObject >> operationId [

	^ operationId
]

{ #category : #accessing }
OpenAPIOperationObject >> operationId: anObject [

	operationId := anObject
]

{ #category : #accessing }
OpenAPIOperationObject >> parameters [

	^ parameters
]

{ #category : #accessing }
OpenAPIOperationObject >> parameters: anObject [

	parameters := anObject
]

{ #category : #accessing }
OpenAPIOperationObject >> requestBody [

	^ requestBody
]

{ #category : #accessing }
OpenAPIOperationObject >> requestBody: anObject [

	requestBody := anObject
]

{ #category : #accessing }
OpenAPIOperationObject >> responses [

	^ responses
]

{ #category : #accessing }
OpenAPIOperationObject >> responses: anObject [

	responses := anObject
]

{ #category : #accessing }
OpenAPIOperationObject >> summary [

	^ summary
]

{ #category : #accessing }
OpenAPIOperationObject >> summary: anObject [

	summary := anObject
]
