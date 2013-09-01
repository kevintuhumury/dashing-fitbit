# widget configuration

unit_system = "METRIC"
date_format = "%H:%M"

fitbit = Fitbit.new unit_system: unit_system, date_format: date_format

  send_event "fitbit", {
    device:   fitbit.device,
    steps:    fitbit.steps,
    calories: fitbit.calories,
    distance: fitbit.distance,
    active:   fitbit.active
  }
SCHEDULER.every "5m", first_in: 0 do |job|
end
