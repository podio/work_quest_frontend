include Java
require 'lib/java/backend.jar'


class Achievement < ActiveRecord::Base

  Importer = com.podio.sample.workquest.Importer
  
  def self.refresh(user)
    importer = Importer.new('zendesk' => {
      'username' => 'holm+zendesk@podio.com',
      'password' => '127345',
      'subdomain' => 'podio',
      'ssl' => 'false'
    })
    
    importer.achievements.each do |achievement|
      if user.last_updated_at.blank? || achievement.date > user.last_updated_at
        user.achievements.create(
          :source => achievement.source,
          :action => achievement.action,
          :timestamp => achievement.date, # Time.at(achievement.date.time/1000)
          :description => achievement.description,
          :points => achievement.points
        )
      end
    end
    
    user.update_attribute(:last_updated_at, Time.now)
  end
  
end
