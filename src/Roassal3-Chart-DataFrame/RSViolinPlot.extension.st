Extension { #name : #RSViolinPlot }

{ #category : #'*Roassal3-Chart-DataFrame' }
RSViolinPlot class >> example03DataSeries [

	| boxPlot1 toothGrowthDose |
	toothGrowthDose := (AIDatasets loadToothGrowth) column: 'dose'.
	boxPlot1 := self fromDataFrame: toothGrowthDose.
	^ boxPlot1 open
]

{ #category : #'*Roassal3-Chart-DataFrame' }
RSViolinPlot class >> example04DataFrame [

	| boxPlot1 toothGrowth |
	toothGrowth := AIDatasets loadToothGrowth.
	boxPlot1 := (self fromDataFrame: toothGrowth) dataColumn: #len.
	boxPlot1 color: Color purple translucent.
	^ boxPlot1 open
]

{ #category : #'*Roassal3-Chart-DataFrame' }
RSViolinPlot class >> example05DataFrameCategoryBy [

	| boxPlot1 toothGrowth |
	toothGrowth := AIDatasets loadToothGrowth.
	boxPlot1 := (self fromDataFrame: toothGrowth) dataColumn: #len; categoryBy: #dose.
	^ boxPlot1 open
]

{ #category : #'*Roassal3-Chart-DataFrame' }
RSViolinPlot class >> example06DataFrameHue [

	| boxPlot1 toothGrowth |
	toothGrowth := AIDatasets loadToothGrowth.
	boxPlot1 := (self fromDataFrame: toothGrowth) dataColumn: #len; hue:#supp.
	^ boxPlot1 open
]

{ #category : #'*Roassal3-Chart-DataFrame' }
RSViolinPlot class >> example07DataFrameCategoryAndHue [

	| boxPlot1 toothGrowth |
	toothGrowth := AIDatasets loadToothGrowth.
	boxPlot1 := (self fromDataFrame: toothGrowth) dataColumn: #len; categoryBy: #dose; hue:#supp.
	^ boxPlot1 open
]
