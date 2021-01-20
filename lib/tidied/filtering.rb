# frozen_string_literal: true

require "date"

class Tidied
  class Filtering
    def initialize(*instructions)
      @defaults = {
        operator: :==,
        accessor: :itself,
        value: nil,
        case_sensitive: true
      }
      @instructions = instructions.map do |instruction|
        @defaults.merge(instruction)
      end
    end

    def execute(collection)
      return false unless collection.respond_to? :select

      @instructions.reduce(collection) do |output, instruction|
        output.select do |item|
          raw_value             =   access_value(from: item, at: instruction[:accessor])
          attribute_value       =   process_value(from: raw_value, given: instruction)

          next false if not attribute_value.respond_to?(instruction[:operator])

          operator_method       =   attribute_value.method(instruction[:operator])
          query_value           =   process_value(from: instruction[:value], given: instruction)

          if operator_method.arity.zero?
            operator_method.call
          elsif operator_method.arity == 1
            operator_method.call(query_value)
          elsif operator_method.arity.abs.positive?
            operator_method.call(*query_value)
          else
            raise Error.new("invalid operator `#{instruction[:operator]}` for `#{attribute_value}` at `#{instruction[:accessor]}`")
          end
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
      return from.map { |v| process_value(from: v, given: given) } if from.respond_to?(:each)
      return from                     if not from.is_a?(String) || from.is_a?(Symbol)
      return from.downcase            if not given[:case_sensitive]

      from
    end
  end
end
