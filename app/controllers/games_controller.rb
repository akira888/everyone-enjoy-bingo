class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy waiting start play ]

  # GET /games
  def index
    @games = Game.order(id: :desc)
  end

  # GET /games/1
  def show
    render :before_entry and return if @game.before_entry?
    render :entry and return if @game.entry?

    @emit_numbers = @game.game_logs.recent.emit_numbers
    render :playing if @game.playing?
    render :finished if @game.finished?
  end

  # GET /games/new
  def new
    @game = Game.new(max_winners: 1, max_players: 4, entry_period_minutes: 5, random_awards: false, need_bingo_lines: 1)
    @game.awards.build
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to new_game_owner_path(@game), status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      redirect_to game_url(@game), notice: "Game was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    redirect_to games_url, notice: "Game was successfully destroyed.", status: :see_other
  end

  def waiting
    @game.waiting!
    redirect_to game_path(@game), status: :see_other, notice: "参加者の受付を開始しました。"
  end

  def start
    @game.start!
    redirect_to game_path(@game), status: :see_other, notice: "ゲームが開始されました！"
  end

  def play
    @machine = Machine.new(@game)
    @machine.spin!

    if @game.over?
      @game.finish!
    end
    # redirect_to game_path(@game), status: :see_other, notice: "こちらの数字がでました！" + @machine.emit_number.to_s
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find_by(owners_url_hash: params[:owners_url_hash])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      game_attributes = %i[title max_winners max_players entry_period_minutes random_awards need_bingo_lines]
      awards_attributes = %i[id title order_number _destroy]
      params.require(:game).permit(game_attributes, awards_attributes: awards_attributes)
    end
end
