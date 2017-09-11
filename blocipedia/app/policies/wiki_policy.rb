class WikiPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :wiki

    def initialize(user, wiki)
      @current_user = user
      @wiki = wiki
    end

    def resolve
      if @current_user.admin? || @current_user.premium?
        wiki.all
      else
        wiki.where(private: false)
      end
    end
  end

  def update?
    user.present?
  end

  def edit?
    user.present?
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
