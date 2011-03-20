class AchievementsController < ApplicationController
  
  def refresh
    Achievement.refresh(current_user)
    redirect_to dashboard_path, :notice => 'Refreshed your achievements'
  end
  
end
