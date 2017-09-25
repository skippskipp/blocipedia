class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @current_user = user
    @wiki = wiki
  end

  def show?
    @current_user.present? || @current_user.admin? || @current_user.premium?
  end

  def update?
    if @current_user.admin? || @wiki.user == @current_user || !@wiki.private? || @wiki.users.include?(@current_user)
      true
    else
      raise Pundit::NotAuthorizedError, "must be logged in"
    end
  end

  def edit?
    if @current_user.admin? || @wiki.user == @current_user || !@wiki.private? || @wiki.users.include?(@current_user)
      true
    else
      raise Pundit::NotAuthorizedError, "must be logged in"
    end
  end

  def new?
    @current_user.present?
  end

  def create?
    @current_user.present?
  end

  def destroy?
    if !@current_user.present?
      false
    elsif @current_user.admin? || @wiki.user == @current_user
      true
    end
  end
  #create and same policy for new, determining whether user can create a private wiki
  #pundit policies allow you to define a scope within a policy
  class Scope
    attr_reader :user, :wiki

    def initialize(user, wiki)
      @current_user = user
      @wiki = wiki
    end

    def resolve
      wikis = []
      if !@current_user
        wikis = Wiki.where(private: false)
      elsif @current_user.role == 'admin'
        wikis = wiki.all
      elsif @current_user.role == 'premium'
        all_wikis = wiki.all
        all_wikis.each do |wiki|
          if wiki.user == @current_user || !wiki.private? || wiki.users.include?(user)
            wikis << wiki
          end
        end
      else
        all_wikis = wiki.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.users.include?(@current_user)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end
