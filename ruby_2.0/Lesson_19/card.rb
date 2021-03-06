# frozen_string_literal: true

class Card
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    puts "#{suit}, #{value}"
  end
end
