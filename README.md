# DelayedTask

```shell
meteor add konecty:delayed-task
```

With this package you can execute tasks that can be called many times in a few period of time and only execute the the task after a certain time without calls or after a defined number of calls.

# Use case
If you want to track if user is typing to save this state into the user record, you will do a lot of updates into user's record, one update for each pressed key.
But if you define a DelayedTask with 1000ms of buffer time and 30 as call limit, you only will update the user's record after user stop typing for 1 second or when user press 30 keys.

```coffeescript
	callTyping = ->
		Meteor.call 'userTyping'

	task = new DelayedTask callTyping, 1000, 30

	Template.textbox.events
		'keydown input': (e) ->
			task.run()
```