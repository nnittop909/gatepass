SystemConfig.find_or_create_by(
	name: "Config-1", 
	deployment_date: DateTime.new(2018, 8, 1) + 8.hours,
	display_time: 60
)