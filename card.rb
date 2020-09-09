class Card

  class << self
    attr_accessor :stack
  end
  @stack = []

  SUITS = ['^','<3','<>','+']
  NAMES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'A', 'K', 'Q', 'J']

  attr_accessor :name, :suit, :count_card

  def self.create_stack
    SUITS.each do |suit|
      NAMES.each_with_index do |name|
        @stack << Card.new(suit, name)
      end
    end
    self.add_counts
  end

  def self.add_counts
    @stack.each do |card|
      if card.name.is_a? Integer
        card.count_card = card.name
      elsif ['K', 'Q', 'J'].include? card.name
        card.count_card = 10
      else
        card.count_card = 11
      end
    end
  end

  def initialize(suit, name, count_card = 0)
    @name = name
    @suit = suit
    @count_card = count_card
  end
end 
