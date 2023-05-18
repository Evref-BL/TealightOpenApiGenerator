Class {
	#name : #OpenAPICreator,
	#superclass : #Object,
	#instVars : [
		'teapotInstance',
		'title',
		'version',
		'description'
	],
	#category : #'OpenAPIGenerator-Creator'
}

{ #category : #accessing }
OpenAPICreator >> buildDefaultServer [

	| server |
	server := OpenAPIServerObject new.
	server url: 'http://localhost:' , self teapotInstance server port asString.
	server description:
		'A sever installed locally in the computer. Perfect to perform some quick tests'.
	^ server
]

{ #category : #'as yet unclassified' }
OpenAPICreator >> buildMediaMapOf: aMethod for: aPragma [

	| mediaMap |
	mediaMap := OpenAPIMediaMap new.
	(self buildMediaTypeOf: aMethod for: aPragma) ifNotNil: [ :mediaType | 
		mediaMap
			perform: (aPragma argumentNamed: #mediaType:) , ':'
			with: mediaType ].
	^ mediaMap
]

{ #category : #'as yet unclassified' }
OpenAPICreator >> buildMediaTypeOf: aCompiledMethod for: aPragma [

	| mediaType schema |
	schema := aPragma argumentNamed: #schema:.
	mediaType := OpenAPIMediaTypeObject new.
	mediaType schema: (schema = 'array'
			 ifTrue: [ OpenAPIArraySchemaObject new ]
			 ifFalse: [ OpenAPIObjectSchemaObject new ]).
	self fillSchema: mediaType schema of: aCompiledMethod for: aPragma.
	^ mediaType
]

{ #category : #accessing }
OpenAPICreator >> buildOpenAPI [

	| apiObject |
	apiObject := OpenAPIObject new
		             openapi: #'3.0.0';
		             info: (OpenAPIInfoObject new
				              title: self title;
				              version: self version;
				              description: self description;
				              yourself);
		             yourself.
	apiObject servers add: (self buildDefaultServer).
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
	(correspondingMethod pragmaAt:
		 #OPEN_API_RESPONSE:description:mediaType:schema:) ifNotNil: [ 
		:pragma | 
		operation responses
			at: (pragma argumentNamed: #OPEN_API_RESPONSE:)
			put: (self buildResponseOf: correspondingMethod for: pragma) ].
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
	pathObject := OpenAPIPathObject new.

	pathObject
		at: pathString
		put: (self buildPathItemFor: aTeaRoute).
	^ pathObject
]

{ #category : #build }
OpenAPICreator >> buildPathItemFor: aTeaRoute [

	| pathItem |
	pathItem := OpenAPIPathItemObject new.
	pathItem
		perform:
			(aTeaRoute requestMatcher methodMatcher asString asLowercase , ':')
				asSymbol
		with: (self buildOperationFrom: aTeaRoute).

	^ pathItem
]

{ #category : #api }
OpenAPICreator >> buildPathParameterFrom: aTeaPlaceholder usedIn: aMethod [

	| parameterObject |
	parameterObject := OpenAPIParameterObject new.
	parameterObject name: aTeaPlaceholder placeholderName.
	parameterObject in1: OpenAPIParameterLocation path.
	parameterObject required: true.
	aMethod pragmas
		detect: [ :pragma | 
			(pragma argumentNamed: #OPEN_API_parameter: ifNone: [ false ])
			= aTeaPlaceholder placeholderName ]
		ifOne: [ :pragma | 
			| schemaString |
			parameterObject schema: (OpenAPISchemaObject for: (pragma argumentNamed: #schema:)) ].
	^ parameterObject
]

{ #category : #'as yet unclassified' }
OpenAPICreator >> buildResponseOf: aCollection for: aPragma [

	| response |
	response := OpenAPIResponseObject new.
	response description: (aPragma argumentNamed: #description).
	(aPragma argumentNamed: #mediaType:) ~= #none ifTrue: [ 
		response content: (self buildMediaMapOf: aCollection for: aPragma) ].
	^ response
]

{ #category : #accessing }
OpenAPICreator >> description [

	^ description
]

{ #category : #accessing }
OpenAPICreator >> description: anObject [

	description := anObject
]

{ #category : #'as yet unclassified' }
OpenAPICreator >> fillSchema: anOpenAPIArraySchemaObject of: aCollection for: aPragma [ 
	
]

{ #category : #'as yet unclassified' }
OpenAPICreator >> initialize [

	title := 'Default API title'.
	version := '1.0.0'.
	description := 'I am a builder for an OpenAPI. Extends me with new value for your own api'
]

{ #category : #accessing }
OpenAPICreator >> teapotInstance [

	^ teapotInstance
]

{ #category : #accessing }
OpenAPICreator >> teapotInstance: anObject [

	teapotInstance := anObject
]

{ #category : #accessing }
OpenAPICreator >> title [

	^ title
]

{ #category : #accessing }
OpenAPICreator >> title: anObject [

	title := anObject
]

{ #category : #accessing }
OpenAPICreator >> version [

	^ version
]

{ #category : #accessing }
OpenAPICreator >> version: anObject [

	version := anObject
]
