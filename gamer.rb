class Gamer

  attr_accessor :player_name, :cash, :player_cards, :count, :cards_on_hand

  def initialize(player_name)
    @player_name = player_name.to_s
    @count = 0
    @cash = 100
    @player_cards = []
    @cards_on_hand = 0
  end

  def cards_value
    @count = 0
    @player_cards.each {|card| @count += card.count_card}
    @count
  end

  def get_card
    @player_cards << Card.stack.pop
    ace_case
    cards_value
    count_cards_on_hand
  end


  def count_cards_on_hand
     @cards_on_hand = @player_cards.count
  end

  def two_ace_case
    if @player_cards.count == 2 && cards_value == 22
      @count = 21
    end
  end

  def ace_case
    if @player_cards.count > 2 && @player_cards.last.count_card == 11 &&
      cards_value > 21
      @player_cards.last.count_card = 1
    end
  end
end
