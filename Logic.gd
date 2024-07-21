extends Node

var SteamAPPID : int = 72200
var RunCount : int = 0
var RunTime : int = 0
var RunTimeInactive : int = 0

var window
var window_is_active

var timer_exists : bool = false

func _ready():
	window = get_viewport().get_window()
	window.connect("focus_entered", Callable(self, "_on_focus_entered"))
	window.connect("focus_exited", Callable(self, "_on_focus_exited"))
	if Steam.steamInit(true, SteamAPPID):
		print("Steam API initialized successfully")
		_get_stats()
		_eval_stats_startup()
		print("Init states: ", "RunCount: ", RunCount, "  RunTime: ", RunTime, "  InactiveRuntime: ", RunTimeInactive)
	else:
		print("Failed to initialize Steam API")

func _process(_delta):
	if timer_exists == false:
		timer_exists = true
		await get_tree().create_timer(1.0).timeout
		_on_Timer_timeout()

func _on_Timer_timeout():
	_eval_stats_timers()
	#print("RunCount is: ", RunCount, "  RunTime: ", RunTime, "  Inactive: ", RunTimeInactive)
	timer_exists = false

func _get_stats():
	RunCount = Steam.getStatInt("RunCount")
	RunTime = Steam.getStatInt("RunTime")
	RunTimeInactive = Steam.getStatInt("RunTimeInactive")

func _eval_stats_startup():
	if RunCount != 0:
		RunCount += 1
		Steam.setStatInt("RunCount", RunCount)
		Steam.storeStats()

func _eval_stats_timers():
	RunTime += 1
	if window_is_active == false :
		RunTimeInactive += 1
	if RunTime != 0:
		Steam.setStatInt("RunTime", RunTime)
		Steam.setStatInt("RunTimeInactive", RunTimeInactive)
		Steam.storeStats()

func _on_focus_entered():
	window_is_active = true

func _on_focus_exited():
	window_is_active = false
