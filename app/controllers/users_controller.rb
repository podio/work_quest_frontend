class UsersController < ApplicationController
  def edit
  end

  def update
    current_user.update_attributes(params[:user])
    redirect_to edit_user_path, :notice => 'User information updated'
  end

end
