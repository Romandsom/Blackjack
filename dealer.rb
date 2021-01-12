class Dealer < Gamer
  def move
    if cards_value < 17 && cards_on_hand == 2
      take_card
    else
      p 'Dealer desided that he has enough cards'
    end
  end
end
