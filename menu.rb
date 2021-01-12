class Menu
  def initialize
    p 'Please, enter your name'
    player_name = gets.chomp
    while player_name.empty?
      puts 'Name can not be empty. Please, enter your name'
      player_name = gets.chomp
    end
    @game = Game.new(player_name)
    new_game_notification
    @game.new_game
    players_report
    player_menu
  end

  def new_game_notification
    p ' * * * * * New game! * * * * * '
  end

  def report_cards(number)
    puts ' '
    puts "#{@game.gamers[number].player_name} cards are:"
    @game.gamers[number].player_cards.each do |card|
      print "  #{card.name}#{card.suit}".to_s
    end
  end

  def report_count(number)
    puts
    puts "#{@game.gamers[number].player_name} count is #{@game.gamers[number].count}"
  end

  def report_cash(number)
    puts "#{@game.gamers[number].player_name} cash is #{@game.gamers[number].cash}"
    puts ' '
  end

  def report(number)
    report_cards(number)
    report_count(number)
    report_cash(number)
  end

  def dealer_report
    puts ''
    puts 'Dealer cards are:'
    @game.gamers[0].cards_on_hand.times { print ' *' }
  end

  def players_report
    dealer_report
    report(1)
  end

  def open
    i = 0
    until i == @game.gamers.count
      report(i)
      i += 1
    end
    @game.game_result
    p @game.winner_name
    cash_report
    new_game_ask
  end

  def cash_report
    @game.gamers.each do |player|
      puts "#{player.player_name} now has #{player.cash} dollars"
    end
  end

  def new_game_ask
    puts ''
    puts 'Press Y for another game or anykey to exit'
    answer = gets.chomp
    if answer == 'Y'
      new_game_notification
      @game.new_game
      players_report
      player_menu
    end
  end

  def player_menu
    loop do
      puts %(
      Choose your action:
      1. Skip
      2. Take card
      3. Open
      0. Exit)
      action = gets.chomp
      case action.to_i
      when 1
        @game.skip
        players_report
      when 2
        @game.take_card
        open
      when 3
        open
      when 0
        break
      else
        p "Error: there are 4 actions avaliable, #{action} is out of range"
      end
    end
  end
end
