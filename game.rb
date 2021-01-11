class Game
  attr_accessor :gamers, :winner_name
  def initialize(player_name)
    @gamers = []
    @gamers << Dealer.new('Dealer')
    @gamers << Gamer.new(player_name)
    @result = []
    @winner = []

  end

  def new_game
    Card.create_stack
    Card.stack.shuffle!
    @gamers.each do |player|
      player.cards_on_hand = 0
      player.player_cards = []
      2.times {player.get_card}
      player.cash -= 10
      player.two_ace_case
    end    
  end

  def counting_cards
    @result = []
    @winner = []

    @gamers.each {|gamer| @result << gamer.cards_value}
    @result = @result.max
    if @result < 22
      @gamers.each {|gamer| @winner << gamer if @result == gamer.cards_value}
    elsif @result > 21
      @gamers.each {|gamer| @winner << gamer if gamer.cards_value < 22}
    end
  end

  def game_result
    counting_cards
    if @winner.count == 2 || @winner.count == 0
      @gamers.each {|player| player.cash += 10}
      @winner_name = "Its a draw!"
    else
      @winner_name = "#{@winner[0].player_name} won"
      @winner[0].cash += 20
    end
  end
end
