class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.user?
      can :create, Link
      can :read, Link
      can :update, Link, user_id: user.id
      can :destroy, Link, user_id: user.id
      can :create, Comment
      can :read, Comment
      can :destroy, Comment, user_id: user.id
    else
      can :read, Link
      can :read, Comment
    end
  end
end
