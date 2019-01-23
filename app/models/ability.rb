class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      can [:index, :show], Book
      can :manage, [Review, BookStatus, Comment], user_id: user.id
      can [:create, :destroy], [Like, BookFavorite], user_id: user.id
      can [:create, :destroy], [Relationship], follower_id: user.id
      can [:destroy], [Relationship], followed_id: user.id
      can [:index, :show], User
    end
  end
end
