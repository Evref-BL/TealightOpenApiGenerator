Trait {
	#name : #TOpenAPISpecification,
	#category : #OpenAPIGenerator
}

{ #category : #'open-api' }
TOpenAPISpecification classSide >> asOpenAPIObject [

	| apiObject |
	apiObject := OpenAPIObject new
		             openapi: self openAPISpecificationVersion;
		             info: (OpenAPIInfoObject new
				              title: self openAPITitle;
				              version: self openAPIVersion;
				              description: self openAPIDescription;
				              yourself);
		             yourself.
	^ apiObject
]

{ #category : #'open-api' }
TOpenAPISpecification classSide >> openAPIDescription [

	^ ''
]

{ #category : #'open-api' }
TOpenAPISpecification classSide >> openAPISpecificationVersion [

	^ #'3.1.0'
]

{ #category : #'open-api' }
TOpenAPISpecification classSide >> openAPITitle [

	^ self subclassResponsibility
]

{ #category : #'open-api' }
TOpenAPISpecification classSide >> openAPIVersion [

	^ self subclassResponsibility
]
