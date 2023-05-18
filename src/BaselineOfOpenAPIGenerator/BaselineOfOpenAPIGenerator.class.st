Class {
	#name : #BaselineOfOpenAPIGenerator,
	#superclass : #BaselineOf,
	#category : #BaselineOfOpenAPIGenerator
}

{ #category : #baselines }
BaselineOfOpenAPIGenerator >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		self defineDependencies: spec.
		self definePackages: spec.
		self defineGroups: spec ]
]

{ #category : #baselines }
BaselineOfOpenAPIGenerator >> defineDependencies: spec [

	spec
		baseline: 'Tealight'
		with: [ spec repository: 'github://astares/Tealight/repository' ]
]

{ #category : #baselines }
BaselineOfOpenAPIGenerator >> defineGroups: spec [
]

{ #category : #baselines }
BaselineOfOpenAPIGenerator >> definePackages: spec [

	spec
		package: 'OpenAPIGenerator'
		with: [ spec requires: #( 'Tealight' ) ]
]
