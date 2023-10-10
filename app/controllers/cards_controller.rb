class CardsController < ApplicationController
  before_action :set_players_card
  before_action :if_game_finished

  # GET /players/h3t5ij/card
  def show
  end

  # GET /players/h3t5ij/card/playing
  def edit
    @emit_numbers = @player.game.game_logs.emit_numbers
  end

  # PATCH/PUT /players/h3t5ij/card
  def update
    if @card.update_numbers(card_params)
      if @player.bingo?
        @player.win!
      end

      if @card.game.over?
        @card.game.finish!
      end

      redirect_to playing_player_card_path(@player), notice: "Card was successfully updated.", status: :see_other
    else
      @emit_numbers = @player.game.game_logs.emit_numbers
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_players_card
    @player = Player.find_by(url_hash: params[:player_url_hash])
    @card = @player.card
  end

  def card_params
    params.require(:card).permit(:key, :number)
  end

  def if_game_finished
    if @player.winner? || @player.game.finished?
      redirect_to @player, notice: "You are already a winner.", status: :see_other and return
    end
  end
end
