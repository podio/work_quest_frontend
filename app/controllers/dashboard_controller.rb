class DashboardController < ApplicationController
  
  def show
    @achievements = current_user.achievements
    @leadboard_users = User.order('points DESC').limit(10).where('users.points IS NOT NULL')
  end
  
end
