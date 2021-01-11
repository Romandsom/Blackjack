class Menu
  def initialize
    p "Please, enter your name"
    player_name = gets.chomp
    while player_name.empty?
      puts "Name can not be empty. Please, enter your name"
      player_name = gets.chomp
    end
    @game = Game.new(player_name)
    @game.new_game
    player_menu
  end

  def new_game_ask
    puts ''
    puts 'Press Y for another game or anykey to exit'
    answer = gets.chomp
    if answer == 'Y'
      @game.new_game
      player_menu
    else
      return
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
        if @game.gamers[0].cards_on_hand > 2
          puts 'You already used your skip move in this distribution'
        else
          @game.gamers[0].move
        end
        @game.dealer_report
        @game.report(1)
      when 2
        @game.gamers[1].get_card
        @game.open
        new_game_ask
      when 3
        @game.open
        new_game_ask
      when 0
        break
      else
        p "Error: there are 4 actions avaliable, #{action} is out of range"
      end
    end
  end
end
