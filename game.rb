class Game
  attr_accessor :gamers, :winner_name

  def initialize(player_name)
    @gamers = []
    @gamers << Dealer.new('Dealer')
    @gamers << Gamer.new(player_name)
    @array_result = []
    @winner_name = String
  end

  def new_game
    Card.create_stack
    Card.stack.shuffle!
    @gamers.each do |player|
      player.cards_on_hand = 0
      player.player_cards = []
      2.times { player.take_card }
      player.cash -= 10
      player.two_ace_case
    end
  end

  def skip
    if gamers[0].cards_on_hand > 2
      puts 'You already used your skip move in this distribution'
    else
      gamers[0].move
    end
  end

  def take_card
    gamers[1].take_card
    gamers[0].move
  end

  def draw_case
    @array_result = []
    @gamers.each { |gamer| @array_result << gamer.cards_value }
    if @array_result.size != @array_result.uniq.size || @array_result.inject(0, :+) > 43
      @winner_name = 'Its a draw!'
      @gamers.each { |player| player.cash += 10 }
    else
      false
    end
  end

  def game_result
    if draw_case == false
      min, max = @array_result.minmax
      if max > 21
        @array_result.delete(max)
      else
        @array_result.delete(min)
      end
      @gamers.each do |gamer|
        if gamer.cards_value == @array_result[0]
          @winner_name = "#{gamer.player_name} has won!"
          gamer.cash += 20
        end
      end
    end
  end
end
