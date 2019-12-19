class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :read, :all
      can :destroy, Advertisement
      can :manage, Advertisement, :opened_advertisements
      can :manage, [User, Category]
    elsif user.user?
      can :read, Advertisement
      can :show, User
      can :show, Category
      can :manage, Advertisement, user_id: user.id
      cannot :update, Advertisement, state: 'opened'
      cannot :opened_advertisements, Advertisement
      can :destroy, Advertisement, user_id: user.id
    else
      can :read, Advertisement
      can :show, User
      can :show, Category
    end
  end

end
