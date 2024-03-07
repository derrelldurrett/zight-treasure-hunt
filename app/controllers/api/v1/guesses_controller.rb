class Api::V1::GuessesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_guess, only: %i[ show update destroy ]

  # GET /guesses/winners
  def winners
    winners = User.where(winner: true).order(distance: :asc).map do|user|
      { user: user.obfuscated_email, distance: user.distance }
    end
    render json: winners, status: :ok
  end

  # GET /guesses/1
  def show
    render json: @guess
  end

  # POST /guesses
  def create
    @guess = Guess.new(guess_params)
    if not current_user.winner? and @guess.evaluate?(current_user)
      render json: { guess: @guess, winner: @guess.user.winner? }, status: :created
    else
      render json: @guess.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /guesses/1
  def update
    if not current_user.winner? and @guess.update(guess_params)
      render json: @guess
    else
      render json: @guess.errors, status: :unprocessable_entity
    end
  end

  # DELETE /guesses/1
  def destroy
    @guess.destroy unless current_user.winner?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guess
      @guess = Guess.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def guess_params
      params.require(:guess).permit(:latitude, :longitude)
    end
end
