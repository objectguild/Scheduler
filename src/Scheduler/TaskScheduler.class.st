Class {
	#name : #TaskScheduler,
	#superclass : #Object,
	#instVars : [
		'running',
		'tasks',
		'accessProtect'
	],
	#category : #Scheduler
}

{ #category : #'as yet unclassified' }
TaskScheduler class >> new [

	^ super new initialize
]

{ #category : #scheduling }
TaskScheduler >> addTask: aScheduledTask [
	^ accessProtect critical: [ tasks add: aScheduledTask ]
]

{ #category : #scheduling }
TaskScheduler >> do: aBlock at: when [
	^ self do: aBlock at: when every: 1 day
]

{ #category : #scheduling }
TaskScheduler >> do: aBlock at: when every: aDuration [
	| newTask |

	newTask := ScheduledTask new 
		scheduler: self;
		task: aBlock;
		startDateAndTime: when duration: aDuration.
	^ self addTask: newTask.
]

{ #category : #scheduling }
TaskScheduler >> do: aBlock every: aDuration [
	^ self do: aBlock at: Time now every: aDuration
]

{ #category : #scheduling }
TaskScheduler >> do: aBlock following: aSchedule [
	| newTask |

	newTask := ScheduledTask new 
		scheduler: self;
		task: aBlock;
		schedule: aSchedule.
	^ self addTask: newTask.
]

{ #category : #scheduling }
TaskScheduler >> doOnce: aBlock at: when [
	^ self do: aBlock at: when every: Duration zero
]

{ #category : #initialization }
TaskScheduler >> initialize [

	running := false.
	tasks := OrderedCollection new.
	accessProtect := Semaphore forMutualExclusion
]

{ #category : #testing }
TaskScheduler >> isRunning [

	^ running.
]

{ #category : #printing }
TaskScheduler >> printOn: aStream [

	aStream
		nextPutAll: 'Task scheduler is ';
		nextPutAll: (running ifTrue: [ 'running' ] ifFalse: [ 'stopped' ]);
		nextPutAll: ' with ';
		nextPutAll: self taskCount asWords;
		nextPutAll: ' tasks'.
]

{ #category : #scheduling }
TaskScheduler >> removeTask: aScheduledTask [
	accessProtect critical: [tasks remove: aScheduledTask]
]

{ #category : #executing }
TaskScheduler >> start [
	| process |

	running ifTrue: [ ^ self ].
	running := true.

	process := [ 
		[ running ] whileTrue: 
			[ 
				250 milliSeconds wait.
				self tasksDo: [ :each | 
					each runIfNecessary ] ] ] newProcess.

	process 
		name: 'taskScheduler';
		priority: Processor systemBackgroundPriority;
		resume.
]

{ #category : #executing }
TaskScheduler >> stop [
	running := false
]

{ #category : #accessing }
TaskScheduler >> taskAt: aNumber [
	^ accessProtect critical: [ tasks at: aNumber ]
]

{ #category : #accessing }
TaskScheduler >> taskCount [
	^ accessProtect critical: [ tasks size ]
]

{ #category : #private }
TaskScheduler >> tasks [
	accessProtect critical: [ ^ tasks copy ]
]

{ #category : #accessing }
TaskScheduler >> tasksDo: aOneArgBlock [
	self tasks do: aOneArgBlock
]
