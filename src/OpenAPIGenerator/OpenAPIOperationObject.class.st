Class {
	#name : #OpenAPIOperationObject,
	#superclass : #Object,
	#instVars : [
		'summary',
		'description',
		'requestBody',
		'responses',
		'operationId'
	],
	#category : #OpenAPIGenerator
}

{ #category : #accessing }
OpenAPIOperationObject >> description [

	^ description
]

{ #category : #accessing }
OpenAPIOperationObject >> description: anObject [

	description := anObject
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
