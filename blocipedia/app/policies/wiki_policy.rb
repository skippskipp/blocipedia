class WikiPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = current_user
    @wiki = wiki
  end

  def update?
    user.admin? or not post.published?
  end
end
