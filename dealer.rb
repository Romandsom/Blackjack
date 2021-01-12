class Dealer < Gamer
  def move
    take_card if cards_value < 17 && cards_on_hand == 2
  end
end
