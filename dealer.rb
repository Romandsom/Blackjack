class Dealer < Gamer

  def move
    if cards_value < 17
      get_card
    else
      p 'Dealer desided that he has enough cards'
    end
  end
end
