class Machine
  attr_reader :emit_number

  BINGO_NUMBERS = (1..75).to_a.freeze

  def initialize(game)
    @game = game
  end

  def spin!
    @emit_number = current_numbers.sample(1).first
    game_log = @game.game_logs.build(emit_number: @emit_number)
    game_log.save!
  end

  private
  def current_numbers
    BINGO_NUMBERS - @game.game_logs.emit_numbers
  end

  private_constant :BINGO_NUMBERS
end
