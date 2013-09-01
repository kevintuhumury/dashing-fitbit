require "fitgem"

class Fitbit

  attr_reader :client, :options

  def initialize(options = {})
    @options = options
    config   = Fitgem::Client.symbolize_keys YAML.load(File.open(".fitbit.yml"))
    @client  = Fitgem::Client.new config[:oauth].merge!(options)
  end

  def device
    {
      version:   [ current_device["deviceVersion"], current_device["type"] ].join(" "),
      battery:   current_device["battery"],
      last_sync: DateTime.iso8601(current_device["lastSyncTime"]).strftime(options[:date_format])
    }
  end

  def steps
    {
      today: summary["steps"],
      total: total["steps"],
      goal:  percentage(summary["steps"].to_i, goals["steps"].to_i)
    }
  end

  def calories
    {
      today: summary["caloriesOut"],
      goal:  percentage(summary["caloriesOut"], goals["caloriesOut"])
    }
  end

  def distance
    {
      today: distance_today,
      goal:  percentage(distance_today.to_f, goals["distance"].to_f).to_i,
      total: total["distance"],
      unit:  distance_unit
    }
  end

  def active
    {
      very: summary["veryActiveMinutes"]
    }
  end

  def errors?
    client.devices.is_a?(Hash) && client.devices.has_key?("errors")
  end

  def error
    client.devices["errors"].first["message"]
  end

  private

  def current_device
    client.devices.first
  end

  def today
    client.activities_on_date("today")
  end

  def total
    client.activity_statistics["lifetime"]["total"]
  end

  def distance_unit
    client.user_info["user"]["distanceUnit"] == "en_US" ? "miles" : "km"
  end

  def distance_today
    summary["distances"].select { |item| item["activity"] == "total" }.first["distance"]
  end

  def summary
    today["summary"]
  end

  def goals
    today["goals"]
  end

  def percentage(current, total)
    current / (total / 100)
  end

end
