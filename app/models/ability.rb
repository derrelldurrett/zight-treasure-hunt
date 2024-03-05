# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
    can [:read, :create], Guess
    return unless user.admin?
    can :manage, :all
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

  end
end
