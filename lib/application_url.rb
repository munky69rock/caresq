# frozen_string_literal: true

class ApplicationUrl
  PROPERTIES = %i[host scheme].freeze

  delegate :to_s, to: :url
  delegate_missing_to :url

  def initialize(request)
    @url = URI.parse(request.original_url)
    PROPERTIES.each do |key|
      instance_variable_set "@#{key}", request.send(key)
    end
    @corrected = false
  end

  def correct!
    PROPERTIES.each do |key|
      correct_property!(key)
    end
  end

  def corrected?
    @corrected
  end

  private

  attr_reader :url

  def correct_property!(key)
    value = request.send(key)
    return if Settings.send(key).nil? || Settings.send(key) == value
    @url.send("#{key}=", Settings.send(key))
    @corrected = true
  end
end
