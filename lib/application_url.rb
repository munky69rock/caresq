# frozen_string_literal: true

class ApplicationUrl
  CORRECTABLE_ATTRIBUTES = %i[host scheme].freeze

  delegate :to_s, to: :url
  delegate_missing_to :url

  def initialize(request, settings = {})
    @url = URI.parse(request.original_url)
    CORRECTABLE_ATTRIBUTES.each do |key|
      instance_variable_set "@#{key}", request.send(key)
    end
    @settings = settings
    @corrected = false
  end

  def correct!
    CORRECTABLE_ATTRIBUTES.each do |key|
      correct_attr!(key)
    end
  end

  def corrected?
    @corrected
  end

  private

  attr_reader :url, :settings

  def correct_attr!(key)
    value = instance_variable_get("@#{key}")
    return if settings[key].nil? || settings[key] == value
    @url.send("#{key}=", settings[key])
    @corrected = true
  end
end
