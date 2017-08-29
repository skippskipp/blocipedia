class UsersController < ApplicationController
  def downgrade
    current_user.role = 1
    current_user.save!
    redirect_to wikis_path, notice: 'You have been downgraded back down with the masses.'
  end
end
