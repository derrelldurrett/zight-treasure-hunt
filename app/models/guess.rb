require 'geo/coord'

class Guess < ApplicationRecord
  belongs_to :user

  TREASURE = Geo::Coord.from_h(JSON.parse ENV['GUESS'])

  def evaluate?(current_user)
    self.user = current_user.clear_guess
    distance = Geo::Coord.new(latitude, longitude).distance(TREASURE)
    if save
      user.handle_winner(distance) if distance < 1000
      true
    else
      false
    end
  end
end
