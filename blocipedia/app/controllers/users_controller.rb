class UsersController < ApplicationController
  def downgrade
    current_user.role = 1
    current_user.save!
    #find all wikis made by current user, change private to false
    wikis = Wiki.all
    wikis.each do |wiki|
      if current_user.username == wiki.user.username
        wiki.private = false
        wiki.save!
      end
    redirect_to wikis_path, notice: 'You have been downgraded back down with the masses. Any of your private wikis are now public.'
  end
end
