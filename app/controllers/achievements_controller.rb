class AchievementsController < ApplicationController
  
  def refresh
    Achievement.refresh
    redirect_to dashboard_path, :notice => 'Refreshed your achievements'
  end
  
end
