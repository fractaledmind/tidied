# frozen_string_literal: true

require_relative "tidied/version"
require_relative "tidied/sorting"
require_relative "tidied/filtering"

class Tidied

  class Error < StandardError; end
  def initialize(collection)
    @collection = collection
  end

  def sort(*instructions)
    Sorting.new(*instructions).execute(@view)
  end

  def filter(*instructions)
    Filtering.new(*instructions).execute(@view)
  end
end
