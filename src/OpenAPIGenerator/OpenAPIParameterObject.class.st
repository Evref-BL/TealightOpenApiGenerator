Class {
	#name : #OpenAPIParameterObject,
	#superclass : #Object,
	#instVars : [
		'name',
		'in',
		'description',
		'required',
		'style',
		'content',
		'schema'
	],
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #accessing }
OpenAPIParameterObject class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping | 
		mapping mapInstVars:
			#( name in description required style content schema ) ]
]

{ #category : #accessing }
OpenAPIParameterObject >> content [

	^ content
]

{ #category : #accessing }
OpenAPIParameterObject >> content: anObject [

	content := anObject
]

{ #category : #accessing }
OpenAPIParameterObject >> description [

	^ description
]

{ #category : #accessing }
OpenAPIParameterObject >> description: anObject [

	description := anObject
]

{ #category : #accessing }
OpenAPIParameterObject >> in [

	^ in
]

{ #category : #accessing }
OpenAPIParameterObject >> in1: anObject [

	in := anObject
]

{ #category : #accessing }
OpenAPIParameterObject >> name [

	^ name
]

{ #category : #accessing }
OpenAPIParameterObject >> name: anObject [

	name := anObject
]

{ #category : #accessing }
OpenAPIParameterObject >> required [

	^ required
]

{ #category : #accessing }
OpenAPIParameterObject >> required: anObject [

	required := anObject
]

{ #category : #accessing }
OpenAPIParameterObject >> schema [

	^ schema
]

{ #category : #accessing }
OpenAPIParameterObject >> schema: anObject [

	schema := anObject
]

{ #category : #accessing }
OpenAPIParameterObject >> style [

	^ style
]

{ #category : #accessing }
OpenAPIParameterObject >> style: anObject [

	style := anObject
]
