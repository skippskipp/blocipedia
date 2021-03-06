class WikisController < ApplicationController

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Your wiki was saved!"
      redirect_to [@wiki]
    else
      flash.now[:alert] = "There was an error saving your wiki. Please try again. I hope you copied your work somewhere else dude."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @possible_collaborators = User.all.where.not(id: current_user.id)
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Your wiki was updated. It is now even more awesomer."
      redirect_to @wiki
    else
      flash.now[:alert] = "Error saving wiki. Please try again. I hope you copied your work somewhere else dude."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the wiki. Sorry about that! Please try again."
      render :show
    end
  end

  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user_ids => [])
  end
end
