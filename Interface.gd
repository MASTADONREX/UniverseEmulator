extends Node

func _process(_delta):
	if Global.RunTime != null:
		convert_seconds(Global.RunTime)

func convert_seconds(total_seconds: int):
	var seconds_in_year : int = 31557600
	var seconds_in_month : int = 2592000
	var seconds_in_week : int = 604800
	var seconds_in_day : int = 86400
	var seconds_in_hour : int = 3600
	var seconds_in_minute : int = 60

	var years : int = total_seconds / seconds_in_year
	total_seconds %= seconds_in_year
	
	var months : int = total_seconds / seconds_in_month
	total_seconds %= seconds_in_month
	
	var weeks : int = total_seconds / seconds_in_week
	total_seconds %= seconds_in_week
	
	var days : int = total_seconds / seconds_in_day
	total_seconds %= seconds_in_day
	
	var hours : int = total_seconds / seconds_in_hour
	total_seconds %= seconds_in_hour
	
	var minutes : int = total_seconds / seconds_in_minute
	total_seconds %= seconds_in_minute
	
	var seconds : int = total_seconds
	
	$Panel/LabelYears/RL.bbcode_text = str(years)
	$Panel/LabelMonths/RL.bbcode_text = str(months)
	$Panel/LabelWeeks/RL.bbcode_text = str(weeks)
	$Panel/LabelDays/RL.bbcode_text = str(days)
	$Panel/LabelHours/RL.bbcode_text = str(hours)
	$Panel/LabelMinuts/RL.bbcode_text = str(minutes)
	$Panel/LabelSeconds/RL.bbcode_text = str(seconds)
	$Panel/LabelRunCount/RL.bbcode_text = str(Global.RunCount)
