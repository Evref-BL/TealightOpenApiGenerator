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
		'The mandatory URL to use for any request'.
	^ server
]

{ #category : #build }
OpenAPICreator >> buildMediaMapOf: aMethod for: aPragma [

	| mediaMap |
	mediaMap := OpenAPIMediaMap new.
	(self buildMediaTypeOf: aMethod for: aPragma) ifNotNil: [ :mediaType | 
		mediaMap
			perform: (aPragma argumentNamed: #mediaType:) , ':'
			with: mediaType ].
	^ mediaMap
]

{ #category : #build }
OpenAPICreator >> buildMediaTypeOf: aCompiledMethod for: aPragma [

	| mediaType schema schemaElement |
	schema := aPragma argumentNamed: #schema:.
	mediaType := OpenAPIMediaTypeObject new.
	schema = 'array'
		ifTrue: [ 
			schemaElement := OpenAPIArraySchemaObject new.
			self fillSchema: schemaElement of: aCompiledMethod for: aPragma ]
		ifFalse: [ 
			aPragma
				argumentNamed: #model:
				ifNone: [ schemaElement := OpenAPIObjectSchemaObject new ].
			schemaElement ifNil: [ 
				schemaElement := self buildSchemaObjectFromClass:
					                 (self class environment at:
						                  (aPragma argumentNamed: #model:) asSymbol) ] ].

	mediaType schema: schemaElement.
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

{ #category : #build }
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
	correspondingMethod pragmas
		detect: [ :pragma | 
		pragma selector keywords first = #OPEN_API_RESPONSE: ]
		ifOne: [ :pragma | 
			operation responses
				at: (pragma argumentNamed: #OPEN_API_RESPONSE:)
				put: (self buildResponseOf: correspondingMethod for: pragma) ].
	(self buildQueryParametersUsedIn: correspondingMethod) do: [ 
		:parameterObject | operation addParameter: parameterObject ].
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
			parameterObject schema:
				(OpenAPISchemaObject for: (pragma argumentNamed: #schema:)).
			parameterObject description:
				(pragma argumentNamed: #description: ifNone: [ nil ]) ].
	^ parameterObject
]

{ #category : #api }
OpenAPICreator >> buildQueryParametersUsedIn: aMethod [

	| parametersObject |
	parametersObject := OrderedCollection new.
	aMethod pragmas
		select: [ :pragma | 
			(pragma argumentNamed: #OPEN_API_Query_parameter: ifNone: [ false ])
			~= false ]
		thenDo: [ :pragma | 
			| parameterObject |
			parameterObject := OpenAPIParameterObject new.
			parameterObject name: (pragma argumentNamed: #OPEN_API_Query_parameter:).
			parameterObject in1: OpenAPIParameterLocation query.
			parameterObject required: false.
			parameterObject schema:
				(OpenAPISchemaObject for: (pragma argumentNamed: #schema:)).
			parameterObject description:
				(pragma argumentNamed: #description: ifNone: [ nil ]).
			parametersObject add: parameterObject ].
	^ parametersObject
]

{ #category : #build }
OpenAPICreator >> buildResponseOf: aCollection for: aPragma [

	| response |
	response := OpenAPIResponseObject new.
	response description: (aPragma argumentNamed: #description).
	(aPragma argumentNamed: #mediaType:) ~= #none ifTrue: [ 
		response content: (self buildMediaMapOf: aCollection for: aPragma) ].
	^ response
]

{ #category : #build }
OpenAPICreator >> buildSchemaIn: schemaObject basedOnClass: aClass [

	aClass allMethods
		select: [ :m | 
			m pragmas anySatisfy: [ :pragma | 
				pragma selector keywords first = #OPEN_API_variable: ] ]
		thenDo: [ :method | 
			| pragma |
			pragma := method pragmas detect: [ :pp | 
				          pp selector keywords first = #OPEN_API_variable: ].
			schemaObject
				propertyAt: (pragma argumentNamed: #OPEN_API_variable:)
				put: (OpenAPISchemaObject for: (pragma argumentNamed: #type:)).
			(schemaObject propertyAt:
				 (pragma argumentNamed: #OPEN_API_variable:)) description:
				method comment.
			(schemaObject propertyAt:
				 (pragma argumentNamed: #OPEN_API_variable:)) title:
				(pragma argumentNamed: #OPEN_API_variable:) ]
]

{ #category : #build }
OpenAPICreator >> buildSchemaIn: schemaObject basedOnMooseClass: aClass [

	aClass allMethods
		select: [ :m | 
			m pragmas anySatisfy: [ :pragma | 
				pragma selector keywords first = #FMProperty: ] ]
		thenDo: [ :method | 
			| pragma |
			pragma := method pragmas detect: [ :pp | 
				          pp selector keywords first = #FMProperty: ].
			schemaObject
				propertyAt: (pragma argumentNamed: #FMProperty:)
				put: (OpenAPISchemaObject for: (pragma argumentNamed: #type:)).

			"comment"
			(schemaObject propertyAt: (pragma argumentNamed: #FMProperty:)) 
				description: (method pragmas
						 detect: [ :pp | pp selector keywords first = #FMComment: ]
						 ifOne: [ :comPragma | comPragma argumentNamed: #FMComment: ]
						 ifNone: [ method comment ifNil: [ '' ] ]).
			(schemaObject propertyAt: (pragma argumentNamed: #FMProperty:)) 
				title: (pragma argumentNamed: #FMProperty:) ].
	schemaObject
		propertyAt: #mooseID
		put: (OpenAPISchemaObject for: #integer).
	(schemaObject propertyAt: #mooseID) description:
		'The id of the element in the model'
]

{ #category : #build }
OpenAPICreator >> buildSchemaObjectFromClass: aClass [

	| schemaObject |
	schemaObject := OpenAPIObjectSchemaObject new.
	(aClass isKindOf: MooseObject class)
		ifTrue: [ 
		self buildSchemaIn: schemaObject basedOnMooseClass: aClass ]
		ifFalse: [ self buildSchemaIn: schemaObject basedOnClass: aClass ].

	^ schemaObject
]

{ #category : #accessing }
OpenAPICreator >> description [

	^ description
]

{ #category : #accessing }
OpenAPICreator >> description: anObject [

	description := anObject
]

{ #category : #build }
OpenAPICreator >> fillArraySchema: anOpenAPIArraySchemaObject of: aCollection for: aPragma [

	| typeName |
	typeName := aPragma argumentNamed: #items: ifNone: [ ^ nil ].
	anOpenAPIArraySchemaObject items: (self buildSchemaObjectFromClass:
			 (self class environment at: typeName asSymbol)).
	^ anOpenAPIArraySchemaObject
]

{ #category : #build }
OpenAPICreator >> fillSchema: anOpenAPIArraySchemaObject of: aCollection for: aPragma [

	(anOpenAPIArraySchemaObject isKindOf: OpenAPIArraySchemaObject) 
		ifTrue: [ 
			^ self
				  fillArraySchema: anOpenAPIArraySchemaObject
				  of: aCollection
				  for: aPragma ].
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
