class CardsController < ApplicationController
  before_action :set_players_card

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
end
