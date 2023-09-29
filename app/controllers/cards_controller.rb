class CardsController < ApplicationController
  before_action :set_players_card

  # GET /players/h3t5ij/card
  def show
  end

  # GET /players/h3t5ij/card/playing
  def edit
  end

  # PATCH/PUT /players/h3t5ij/card
  def update
    if @card.update(card_params)
      redirect_to @card, notice: "Card was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_players_card
      @player = Player.find_by(url_hash: params[:player_url_hash])
      @card = @player.card
    end

    def card_params
      params.require(:card).permit(:number)
    end
end
