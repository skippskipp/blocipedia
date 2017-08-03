class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
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
  end

  def update
    @wiki = Wiki.find(params[:id])

    @wiki.assign_attributes(wiki_params)

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
    params.require(:wiki).permit(:title, :body)
  end
end
