# widget configuration

unit_system   = "METRIC"
date_format   = "%H:%M"
animate_views = true

fitbit = Fitbit.new unit_system: unit_system, date_format: date_format

SCHEDULER.every "5m", first_in: 0 do |job|
  if fitbit.errors?
    send_event "fitbit", { error: fitbit.error }
  else
    send_event "fitbit", {
      device:   fitbit.device,
      steps:    fitbit.steps,
      calories: fitbit.calories,
      distance: fitbit.distance,
      active:   fitbit.active,
      animate:  animate_views
    }
  end
end
