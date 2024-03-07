class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_one :guess

  def clear_guess
    self.guess&.destroy!
    save
    self
  end

  def handle_winner(winning_distance)
    self.winner = true
    self.distance = winning_distance
    save
    WinnerMailer.with(user: self).winner_email.deliver_now
  end

  def obfuscated_email
    obfuscated = self.email
    dot = obfuscated.rindex('.')+1
    obfuscated[dot+1, obfuscated.length - dot] = '**'
    at = obfuscated.index('@')+2
    dot = obfuscated.rindex('.')
    obfuscated[at, dot-at] = '**'
    obfuscated[2, at-4] = '***'
    obfuscated
  end
end
