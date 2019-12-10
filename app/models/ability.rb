class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :read, :all
      can :destroy, Advertisement
      can :manage, User
      can :manage, Category
    elsif user.user?
      can :read, Advertisement
      can :show, User
      can :show, Category
      can :manage, Advertisement, user_id: user.id
    else
      can :read, Advertisement
      can :show, User
      can :show, Category
    end
  end

end
