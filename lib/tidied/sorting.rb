# frozen_string_literal: true

require "date"

class Tidied
  class Sorting
    def initialize(*instructions)
      @defaults = {
        direction: :ascending,
        nils: :small,
        accessor: :itself,
        case_sensitive: true,
        normalized: false,
        natural: false
      }
      @instructions = instructions.map do |instruction|
        @defaults.merge(instruction)
      end
    end

    def execute(collection)
      collection.sort_by do |item|
        @instructions.map do |instruction|
          raw_value             =   access_value(from: item, at: instruction[:accessor])
          processed_value       =   process_value(from: raw_value, given: instruction)
          numeric_value         =   numeric_value(from: processed_value)
          direction_multiplier  =   direction_multiplier(given: instruction[:direction])
          nils_multiplier       =   nils_multiplier(given: instruction[:nils])

          # p({ raw_value: raw_value, processed_value: processed_value, numeric_value: numeric_value, direction_multiplier: direction_multiplier, nils_multiplier: nils_multiplier })

          if numeric_value.nil?                           # [1, 0] [-1, 0]
            [direction_multiplier * nils_multiplier, 0]
          else                                            # [0, n] [0, -n]
            [0, numeric_value * direction_multiplier]
          end                                             # [-1, 0] [0, -n] [0, n] [1, 0]
        end
      end
    end

    private

    def access_value(from:, at:)
      path = at.to_s.split('.')
      path.reduce(from) do |object, signal|
        break nil unless object.respond_to? signal

        object.public_send(signal)
      end
    end

    def process_value(from:, given:)
      return from                     if not from.is_a?(String) || from.is_a?(Symbol)
      return from.downcase            if not given[:case_sensitive]
      return normalize(from) + from   if given[:normalized]
      return segment(from)            if given[:natural]

      from
    end

    def numeric_value(from:)
      return from   if from.is_a?(Numeric)
      return 1      if from == true
      return 0      if from == false

      if from.is_a?(String) || from.is_a?(Symbol)
        string_to_numeric_value(from)
      elsif from.is_a?(Date)
        time_to_numeric_value(Time.new(from.year, from.month, from.day, 00, 00, 00, 00))
      elsif from.respond_to?(:to_time)
        time_to_numeric_value(from.to_time)
      elsif from.respond_to?(:map)
        segment_array_to_numeric_value(from)
      else
        from
      end
    end

    def direction_multiplier(given:)
      return -1 if given == :descending

      1
    end

    def nils_multiplier(given:)
      return -1 if given == :small

      1
    end

    def string_to_numeric_value(string)
      string                                          # "aB09ü""
        .chars                                        # ["a", "B", "0", "9", "ü"]
        .map { |char| char.ord.to_s.rjust(3, '0') }   # ["097", "066", "048", "057", "252"]
        .insert(1, '.')                               # ["097", ".", "066", "048", "057", "252"]
        .reduce(&:concat)                             # "097.066048057252"
        .to_r                                         # (24266512014313/2500000000000)
    end

    def time_to_numeric_value(time) # https://stackoverflow.com/a/30604935/2884386
      time                                            # 2000-01-01 00:00:00 +0000
        .utc                                          # 2000-01-01 00:00:00 UTC
        .to_f                                         # 946684800.0
        .*(1000)                                      # 946684800000.0
        .round                                        # 946684800000
    end

    def segment_array_to_numeric_value(segments)
      segments                                        # ["a", 12, "b", 34, "c"]
        .map { |x| x.is_a?(Numeric) ? x : x.ord }     # [97, 12, 98, 34, 99]
        .map { |n| (n + 1).to_s.rjust(3, '0') }       # ["098", "013", "099", "035", "100"]
        .insert(1, '.')                               # ["098", ".", "013", "099", "035", "100"]
        .join                                         # "098.013099035100"
        .to_r                                         # (980130990351/100000000000)
    end

    def normalize(string) # https://github.com/grosser/sort_alphabetical
      string                                          # "Äaáäßs"
        .unicode_normalize(:nfd)                      # "Äaáäßs"
        .downcase(:fold)                              # "äaáässs"
        .chars                                        # ["a", "̈", "a", "a", "́", "a", "̈", "s", "s", "s"]
        .select { |char| char =~ /[[:ascii:]]/ }      # ["a", "a", "a", "a", "s", "s", "s"]
        .join                                         # "aaaasss"
    end

    def segment(string) # https://stackoverflow.com/a/15170063/2884386
      digits_or_not_digit_regex = /[[:digit:]]+|[^[:digit:]]/

      string                                          # "ab12cd34,-56"
        .scan(digits_or_not_digit_regex)             # ["a", "b", "12", "c", "d", "34", ",", "-", "56"]
        .map { |a| a =~ /[[:digit:]]+/ ? a.to_i : a } # ["a", "b", 12, "c", "d", 34, ",", "-", 56]
    end
  end
end
