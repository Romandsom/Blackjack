class Dealer < Gamer

  def move
    if cards_value < 17 && self.cards_on_hand == 2
      get_card
    else
      p 'Dealer desided that he has enough cards'
    end
  end
end
