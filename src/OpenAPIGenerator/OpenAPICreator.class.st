Class {
	#name : #OpenAPICreator,
	#superclass : #Object,
	#instVars : [
		'teapotInstance'
	],
	#category : #'OpenAPIGenerator-Creator'
}

{ #category : #accessing }
OpenAPICreator >> buildOpenAPI [

	| apiObject |
	apiObject := OpenAPIObject new
		             openapi: #'3.1.0';
		             info: (OpenAPIInfoObject new
				              title: 'title';
				              version: 'version';
				              description: 'description';
				              yourself);
		             yourself.
	teapotInstance dynamicRoutes do: [ :dynamicRoute | 
		apiObject addPath: (self buildPathFromRoute: dynamicRoute) ].
	^ apiObject
]

{ #category : #'as yet unclassified' }
OpenAPICreator >> buildOperationFrom: aTeaRoute [

	| operation correspondingMethod placeholders |
	operation := OpenAPIOperationObject new.
	correspondingMethod := aTeaRoute action receiver class
	                       >> aTeaRoute action selector.
	operation summary: correspondingMethod comment.
	operation description: correspondingMethod comment.
	placeholders := aTeaRoute requestMatcher urlPattern segments select: [ 
		                :segment | segment isKindOf: TeaPlaceholder ].
	placeholders do: [ :placeholder | 
		operation addParameter:
			(self
				 buildPathParameterFrom: placeholder
				 usedIn: correspondingMethod) ].
	^ operation
]

{ #category : #build }
OpenAPICreator >> buildPathFromRoute: aTeaRoute [

	| pathString pathObject |
	pathString := String streamContents: [ :stream | 
		              stream << '/'.
		              aTeaRoute requestMatcher urlPattern segments
			              do: [ :segment | 
				              (segment isKindOf: TeaLiteral)
					              ifTrue: [ stream << segment literal ]
					              ifFalse: [ 
						              stream
							              << '{';
							              << segment placeholderName;
							              << '}' ] ]
			              separatedBy: [ stream << '/' ] ].
	pathObject := OpenAPIPathObject new
		              endpoint: pathString;
		              yourself.
	
	pathObject addPathItem: (self buildPathItemFor: aTeaRoute).
	^ pathObject
]

{ #category : #build }
OpenAPICreator >> buildPathItemFor: aTeaRoute [

	| pathItem |
	pathItem := OpenAPIPathItemObject new.
	pathItem action:
		aTeaRoute requestMatcher methodMatcher asString asLowercase.
	pathItem operation: (self buildOperationFrom: aTeaRoute).

	^ pathItem
]

{ #category : #api }
OpenAPICreator >> buildPathParameterFrom: aTeaPlaceholder usedIn: aCollection [

	| parameterObject |
	parameterObject := OpenAPIParameterObject new.
	parameterObject name: aTeaPlaceholder placeholderName.
	parameterObject in1: OpenAPIParameterLocation path.
	parameterObject required: true.
	^ parameterObject
]

{ #category : #accessing }
OpenAPICreator >> teapotInstance [

	^ teapotInstance
]

{ #category : #accessing }
OpenAPICreator >> teapotInstance: anObject [

	teapotInstance := anObject
]
