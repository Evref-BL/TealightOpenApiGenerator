Class {
	#name : #OpenAPIPathItemObject,
	#superclass : #Object,
	#instVars : [
		'get',
		'put',
		'post'
	],
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #accessing }
OpenAPIPathItemObject class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping | mapping mapAllInstVars ]
]

{ #category : #accessing }
OpenAPIPathItemObject >> get [

	^ get
]

{ #category : #accessing }
OpenAPIPathItemObject >> get: anObject [

	get := anObject
]

{ #category : #accessing }
OpenAPIPathItemObject >> post [

	^ post
]

{ #category : #accessing }
OpenAPIPathItemObject >> post: anObject [

	post := anObject
]

{ #category : #accessing }
OpenAPIPathItemObject >> put [

	^ put
]

{ #category : #accessing }
OpenAPIPathItemObject >> put: anObject [

	put := anObject
]
