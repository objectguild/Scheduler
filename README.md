# Scheduler
Adapted from:
- http://smalltalkhub.com/#!/~TorstenBergmann/Scheduler
- http://www.squeaksource.com/Scheduler/

Slightly modified and tested with Pharo 7.0.

## Description
An easy-to-use task scheduler that can run arbitrary blocks:

 * Every so often (e.g. every hour starting now)
 * Daily at a given time
 * Periodically starting at a given time (e.g. every other hour starting a noon)
 * Per a provide schedule (e.g. using Schedule instance you can run tasks every Monday and Friday)
 * A one time task at some point in the future 

For ease of use tasks can be blocks passed to the scheduler (or any object that understands #value). For example:

```
"Start a new task scheduler and keep it around"
scheduler := TaskScheduler new.
scheduler start.

"Let's save the image every hour"
scheduler
  do: [Smalltalk snapshot: true andQuit: false]
  every: 60 minutes.

"Let's run a backup at 2am every day"
scheduler
  do: ["backup code here"]
  at: '2am'

"Let's perform a bank transfer every other hour starting at 1pm"
scheduler
  do: ["swiss bank account transfer code"]
  at: '1pm'
  every: 2 hours.

"Let's do a one time email reminder"
scheduler
  doOnce: ["email reminder to go on honeymoon"]
  at: '2005-1-15T8:00'

"You can delete tasks by sending #delete to them"
(scheduler taskAt: 1) delete

"Stop the scheduler from running -- but don't delete its tasks"
scheduler stop.
```

Read the provided tests for more examples.
