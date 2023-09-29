class CardsController < ApplicationController
  before_action :set_card, only: %i[ show edit update ]

  # GET /cards/1
  def show
  end

  # GET /cards/1/edit
  def edit
  end

  # PATCH/PUT /cards/1
  def update
    if @card.update(card_params)
      redirect_to @card, notice: "Card was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.fetch(:card, {})
    end
end
