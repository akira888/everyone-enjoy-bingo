class OwnersController < ApplicationController
  before_action :set_owner, only: %i[ show edit update destroy ]

  # GET /owners
  def index
    @owners = current_game.owner
  end

  # GET /owners/1
  def show
  end

  # GET /owners/new
  def new
    @owner = current_game.build_owner
    @owner.name = current_game.owners_url_hash
    @owner.password = revive_spell
  end

  # GET /owners/1/edit
  def edit
  end

  # POST /owners
  def create
    @owner = current_game.build_owner(owner_params)

    if @owner.save
      redirect_to game_owner_url(@game, @owner), notice: "主催者情報が登録できましたね！いよいよゲームを始めましょう"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /owners/1
  def update
    if @owner.update(owner_params)
      redirect_to game_owner_url(@game,@owner), notice: "Owner was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
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
    params.require(:owner).permit(:login_name, :password)
  end

  def revive_spell
    spell_base = [*"あ".."ん"] - ["ぁ", "ぃ", "ぅ", "ぇ", "ぉ", "っ", "ゃ", "ゅ", "ょ", "ゎ", "ゐ", "ゑ"]
    spell = ""
    20.times { spell << spell_base.sample }

    spell
  end
end
