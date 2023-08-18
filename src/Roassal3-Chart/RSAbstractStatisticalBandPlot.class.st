Class {
	#name : #RSAbstractStatisticalBandPlot,
	#superclass : #RSAbstractBandPlot,
	#instVars : [
		'model',
		'models',
		'dataBlock'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #accessing }
RSAbstractStatisticalBandPlot class >> data: aCollection [
	| boxPlot |
	boxPlot := self new.
	boxPlot data: aCollection.
	^ boxPlot
]

{ #category : #private }
RSAbstractStatisticalBandPlot >> createBandShapeFor: anObject dataset: dataset [
	self assert: dataset notEmpty description: 'dataset can not be empty'.
	self subclassResponsibility.
]

{ #category : #private }
RSAbstractStatisticalBandPlot >> createBandShapesFromDataSets: collectionOfDatasets [
	| groupOfModels newViolinShapes |
	groupOfModels := models.
	groupOfModels ifNil: [ groupOfModels := Array new: collectionOfDatasets size ].
	
	newViolinShapes := groupOfModels with: collectionOfDatasets collect: [ :anObject :dataset | 
		self createBandShapeFor: anObject dataset: dataset.
		 ].
	self bandPlotShapes: newViolinShapes
]

{ #category : #accessing }
RSAbstractStatisticalBandPlot >> createdShapes [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractStatisticalBandPlot >> data [
	| collectionOfDatasets |
	collectionOfDatasets := bandPlotShapes collect: [ :violin | violin data ].
	collectionOfDatasets size = 1 ifTrue: [ collectionOfDatasets := collectionOfDatasets first].
	^ collectionOfDatasets.
]

{ #category : #public }
RSAbstractStatisticalBandPlot >> data: dataset [
	
	"dataset could be:
	- aCollection of raw data (numbers)
	- aCollection of collections
	- aBlock to get the data from the model (previously stored in model)"
	
	| collectionOfDatasets |
	dataset isBlock ifTrue: [ dataBlock := dataset ].
	collectionOfDatasets := self extractDatasetsFrom: dataset.
	self createBandShapesFromDataSets: collectionOfDatasets.
]

{ #category : #private }
RSAbstractStatisticalBandPlot >> datasetsFromModels: data [
	models ifNil: [ ^ data ].
	^ models collect: [:anOjbect | data rsValue: anOjbect ].
]

{ #category : #'accessing - defaults' }
RSAbstractStatisticalBandPlot >> defaultShape [
	^ self subclassResponsibility
]

{ #category : #'accessing - computed' }
RSAbstractStatisticalBandPlot >> extractDatasetsFrom: data [
	| result datasets |
	datasets := self datasetsFromModels: data.
	self assert: datasets isCollection description: 'use a collection of numbers'.
	self assert: datasets isNotEmpty description: 'You can not have empty collection'.
	result := datasets first isCollection 
		ifTrue: [ datasets ]
		ifFalse: [ { datasets } ].
	^ result
]

{ #category : #accessing }
RSAbstractStatisticalBandPlot >> model [
	^ model
]

{ #category : #rendering }
RSAbstractStatisticalBandPlot >> model: aModel [
	model := aModel.
]

{ #category : #rendering }
RSAbstractStatisticalBandPlot >> models [
	^ models
]

{ #category : #public }
RSAbstractStatisticalBandPlot >> models: aCollectionOfModels [
	models := aCollectionOfModels
]
