class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show ]

  # GET /players/1
  def show
    @card = @player.card
    @game = @player.game
  end

  # GET /entry/[:game_players_url_hash]
  def new
    @game = Game.find_by!(players_url_hash: params[:game_players_url_hash])
    render :entry_end and return unless @game.entry?
    @user = User.new
    @player = @user.players.new(game_id: @game.id)
  end

  # POST /players
  def create
    @user = User.new(player_params[:user_attributes])
    @game = Game.find(player_params[:game_id])
    unless @user.save
      return render :new, status: :unprocessable_entity
    end

    @player = @user.players.new(player_params)
    @player.build_card(game_id: @game.id)

    if @player.save
      redirect_to @player, notice: "Player was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
  def set_player
    @player = Player.find_by(url_hash: params[:url_hash])
  end

  # Only allow a list of trusted parameters through.
  def player_params
    player_attributes = %i[game_id]
    user_attributes = %i[name]
    params.require(:player).permit(player_attributes, user_attributes: user_attributes)
  end
end
