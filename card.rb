class Card
  class << self
    attr_accessor :stack
  end
  @stack = []

  SUITS = ['^', '<3', '<>', '+'].freeze
  NAMES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'A', 'K', 'Q', 'J'].freeze

  attr_accessor :name, :suit, :count_card

  class << self
    def create_stack
      SUITS.each do |suit|
        NAMES.each do |name|
          @stack << Card.new(suit, name)
        end
      end
      add_counts
    end

    def add_counts
      @stack.each do |card|
        card.count_card = if card.name.is_a? Integer
                            card.name
                          elsif %w[K Q J].include? card.name
                            10
                          else
                            11
                          end
      end
    end
  end

  def initialize(suit, name, count_card = 0)
    @name = name
    @suit = suit
    @count_card = count_card
  end
end
