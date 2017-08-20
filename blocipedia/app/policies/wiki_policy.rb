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
end
