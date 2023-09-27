class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show edit update destroy ]

  # GET /players
  def index
    @players = Player.all
  end

  # GET /players/1
  def show
  end

  # GET /entry/[:game_players_url_hash]
  def new
    @game = Game.find_by!(players_url_hash: params[:game_players_url_hash])
    render :entry_end and return unless @game.entry?
    @user = User.new
    @player = @user.players.new(game_id: @game.id)
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  def create
    @user = User.new(player_params[:user_attributes])
    @game = Game.find(player_params[:game_id])
    unless @user.save
      return render :new, status: :unprocessable_entity
    end

    @player = @user.players.new(player_params)

    if @player.save
      redirect_to @player, notice: "Player was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /players/1
  def update
    if @player.update(player_params)
      redirect_to @player, notice: "Player was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /players/1
  def destroy
    @player.destroy
    redirect_to players_url, notice: "Player was successfully destroyed.", status: :see_other
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
