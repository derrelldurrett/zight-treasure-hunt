# frozen_string_literal: true

class WinnerMailer < ApplicationMailer
  def winner_email
    @user = params[:user]
    @distance = @user.distance
    @latitude = @user.guess.latitude
    @longitude = @user.guess.longitude
    mail(to: @user.email, subject: "You're a winner!")
  end
end
