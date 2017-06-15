# frozen_string_literal: true

class StringConverter
  FULL_HYPHEN_FAMILY = {
    soft_hyphen: 173,
    hyphen: 8208,
    non_breaking_hyphen: 8209,
    figure_dash: 8210,
    en_dash: 8211,
    em_dash: 8212,
    horizontal_bar: 8213,
    minus: 8722,
    full_long_vowel: 12_540,
    half_long_vowel: 65_392
  }.map { |k, v| [k, v.chr(Encoding::UTF_8)] }.to_h.freeze

  class << self
    def f2h(string)
      %i[f2h_number f2h_hyphen].map { |method| string = send(method, string) }
      string
    end

    def f2h_number(string)
      string.tr('０-９', '0-9')
    end

    def f2h_hyphen(string)
      string.gsub(/[#{FULL_HYPHEN_FAMILY.values.join}]/, '-')
    end
  end
end
