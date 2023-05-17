Class {
	#name : #BaselineOfOpenAPIGenerator,
	#superclass : #Object,
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
]

{ #category : #baselines }
BaselineOfOpenAPIGenerator >> defineGroups: spec [
]

{ #category : #baselines }
BaselineOfOpenAPIGenerator >> definePackages: spec [

	spec package: 'OpenAPIGenerator'
]
