class OwnersController < ApplicationController
  before_action :set_owner, only: %i[ show edit update destroy ]

  # GET /game/1/owner
  def index
    # なにもしない
  end

  # GET /game/1/owner
  def show
  end

  # GET /game/1/owner/new
  def new
    @owner = current_game.build_owner
    @owner.name = current_game.owners_url_hash
    @owner.password = revive_spell
  end


  # POST /game/1/owner
  def create
    @owner = current_game.build_owner(owner_params)

    if @owner.save
      redirect_to game_owner_url(@game), notice: "主催者情報が登録できましたね！いよいよゲームを始めましょう"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_owner
    @owner = current_game.owner
  end

  def current_game
    @game ||= Game.find(params[:game_id])
  end

  # Only allow a list of trusted parameters through.
  def owner_params
    params.require(:owner).permit(:name, :password)
  end

  def revive_spell
    spell_base = [*"あ".."ん"] - ["ぁ", "ぃ", "ぅ", "ぇ", "ぉ", "っ", "ゃ", "ゅ", "ょ", "ゎ", "ゐ", "ゑ"]
    spell = ""
    20.times { spell << spell_base.sample }

    spell
  end
end
