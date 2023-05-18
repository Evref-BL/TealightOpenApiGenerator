Class {
	#name : #OpenAPIMediaMap,
	#superclass : #Object,
	#instVars : [
		'json'
	],
	#category : #'OpenAPIGenerator-Model'
}

{ #category : #accessing }
OpenAPIMediaMap class >> neoJsonMapping: mapper [

	mapper for: self do: [ :mapping | mapping mapAllInstVars ]
]

{ #category : #accessing }
OpenAPIMediaMap >> json [

	^ json
]

{ #category : #accessing }
OpenAPIMediaMap >> json: anObject [

	json := anObject
]
