class Game
  attr_accessor :gamers
  def initialize(player_name)
    @gamers = []
    @gamers << Dealer.new('Dealer')
    @gamers << Gamer.new(player_name)
    @result = []
    @winner = []

  end

  def new_game
    p "New game!"
    Card.create_stack
    Card.stack.shuffle!
    @gamers.each do |player|
      player.cards_on_hand = 0
      player.player_cards = []
      2.times {player.get_card}
      player.cash -= 10
      player.two_ace_case
    end
    dealer_report
    report(1)
  end

  def dealer_report
    puts ''
    puts 'Dealer cards are:'
    @gamers[0].cards_on_hand.times {print " *"}
  end

  def report(number)
    puts ' '
    puts "#{@gamers[number].player_name} cards are:"
    @gamers[number].player_cards.each do|card|
      print "#{"  " + card.name.to_s + card.suit.to_s}"
    end
    puts
    puts "#{@gamers[number].player_name} count is #{@gamers[number].count}"
    puts "#{@gamers[number].player_name} cash is #{@gamers[number].cash}"
    puts ' '
  end

  def who_win_count
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
    if @winner.count == 2 || @winner.count == 0
      @gamers.each {|player| player.cash += 10}
      p 'Its a draw'
      cash_report
    else
      p  "#{@winner[0].player_name} won"
      @winner[0].cash += 20
      cash_report
    end
  end

  def cash_report
    @gamers.each do |player|
      puts "#{player.player_name} now has #{player.cash} dollars"
    end
  end

  def open
    i = 0
    until i == gamers.count
      report(i)
      i += 1
    end
    who_win_count
    game_result
  end
end
