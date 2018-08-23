Class {
	#name : #BaselineOfScheduler,
	#superclass : #BaselineOf,
	#category : #BaselineOfScheduler
}

{ #category : #catalog }
BaselineOfScheduler class >> catalogContactInfo [
	^ 'astares@gmx.de'
]

{ #category : #catalog }
BaselineOfScheduler class >> catalogDescription [
	^ 'An easy-to-use task scheduler that can run arbitrary blocks:

- Every so often (e.g. every hour starting now)
- Daily at a given time
- Periodically starting at a given time (e.g. every other hour starting a noon)
- Per a provide schedule (e.g. using Schedule instance you can run tasks every Monday and Friday)
- A one time task at some point in the future'
]

{ #category : #catalog }
BaselineOfScheduler class >> catalogKeywords [
	^ #( scheduler cron 'repeated-tasks' )
]

{ #category : #baselines }
BaselineOfScheduler >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec package: 'Scheduler' ]
]
