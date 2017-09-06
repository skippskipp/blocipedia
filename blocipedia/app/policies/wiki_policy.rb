class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @current_user = user
    @wiki = wiki
  end

  def update?

    #user.admin? or not post.published?
  end

  def show?
    true
  end

  def new?

  end

  def create?

  end

  #create and same policy for new, determining whether user can create a private wiki
  #pundit policies allow you to define a scope within a policy
end
