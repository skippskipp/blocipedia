class CollaboratorsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @collaborator = Collaborator.new
  end

  def create
    @collaborator = Collaborator.new(collaborator_params)
    @wiki = Wiki.find_by(id: params[:collaborator][:wiki_id])
    @user = User.find(params[:collaborator][:user_id])
    if @collaborator.save
      flash[:notice] = "You have added this collaborator"
      redirect_to @wiki
    else
      flash[:error] = "There was an error adding the collaborator, please retry"
      render :show
    end
  end

  def destroy

    @collaborator = Collaborator.find_by(params[:id])

    if @collaborator.destroy
      flash[:notice] = "You have removed this collaborator"
      redirect_to @collaborator.wiki
    else
      flash[:error] = "There was an error removing the collaborator, please retry"
      redirect_to @collaborator.wiki
    end
  end

  private
  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end
end
