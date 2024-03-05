class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # user needs a Guess, and a boolean calling them a winner if they are.
  def generate_jwt
    JWT.encode({ id: id, exp: 60.days.from_now.to_i },
                 Rails.application.secrets.secret_key_base)
  end
end
