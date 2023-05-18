Class {
	#name : #OpenAPIAPI,
	#superclass : #Object,
	#category : #'OpenAPIGenerator-API'
}

{ #category : #accessing }
OpenAPIAPI class >> api: aRequest [

	"Return the OpenAPI documentation of the current teapot instance"

	<REST_API: 'GET' versions: #( 'v1' ) pattern: 'api'>
	<OPEN_API_RESPONSE: #'200' description: 'OK' mediaType: #json schema:
	#object>
	| creator api |
	creator := OpenAPICreator new.
	creator teapotInstance: TLWebserver teapot.
	creator version: '3.0.0'.
	creator description: 'An API to request Moose model'.
	creator title: 'Moose API'.
	api := creator buildOpenAPI.


	^ TeaOutput json value: (TeaResponse ok body: api)
]

{ #category : #'class initialization' }
OpenAPIAPI class >> reset [
	<script>
	TLWebserver teapot removeAllDynamicRoutes
]
