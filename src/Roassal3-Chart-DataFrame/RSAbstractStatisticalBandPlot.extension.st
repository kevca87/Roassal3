Extension { #name : #RSAbstractStatisticalBandPlot }

{ #category : #'*Roassal3-Chart-DataFrame' }
RSAbstractStatisticalBandPlot >> categoryBy: aColumnName [

	| newModels newLabels |
	newModels := OrderedCollection new.
	newLabels := OrderedCollection new.
	models do: [ :df |
		| categories |
		categories := (model column: aColumnName) removeDuplicates sort.
		categories do: [ :category |
			| newDataFrame |
			newDataFrame := df select: [ :row |
				                (row at: aColumnName) = category ].
			newModels add: newDataFrame.
			newLabels add: category ] ].
	self models: newModels.
	self data: dataBlock.
	self bandsTicksLabels: newLabels.
	self bandLabel: aColumnName.
]

{ #category : #'*Roassal3-Chart-DataFrame' }
RSAbstractStatisticalBandPlot >> dataColumn: aColumnName [
	
	self data: [ :df | (df column: aColumnName) asArray ].
	self dataLabel: aColumnName.
]

{ #category : #'*Roassal3-Chart-DataFrame' }
RSAbstractStatisticalBandPlot >> dataSeries: aDataSeries [
	self data: aDataSeries asArray.
	self ylabel: aDataSeries name.
]

{ #category : #'*Roassal3-Chart-DataFrame' }
RSAbstractStatisticalBandPlot class >> fromDataFrame: aDataFrame [
	| violinPlot |
	violinPlot := self new.
	violinPlot model: aDataFrame.
	violinPlot models: { aDataFrame }.
	aDataFrame class = DataSeries ifTrue: [ 
		violinPlot data: [ aDataFrame asArray ] ].
	^ violinPlot
]

{ #category : #'*Roassal3-Chart-DataFrame' }
RSAbstractStatisticalBandPlot >> hue: aColumnName [

	| categories clusteredChart |
	categories := (model column: aColumnName) removeDuplicates sort.

	clusteredChart := RSClusterChart new.

	categories doWithIndex: [ :category :idx |
		| newModels newViolinPlot |
		newViolinPlot := self class new.
		newModels := OrderedCollection new.
		models do: [ :df |
			| newDataFrame |
			newDataFrame := df select: [ :row |
				                (row at: aColumnName) = category ].
			newModels add: newDataFrame ].
		newViolinPlot models: newModels.
		newViolinPlot data: dataBlock.
		clusteredChart := clusteredChart + newViolinPlot ].
	^ clusteredChart
]
