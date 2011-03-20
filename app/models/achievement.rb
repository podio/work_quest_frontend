include Java
require 'lib/java/backend.jar'


class Achievement < ActiveRecord::Base

  Importer = com.podio.sample.workquest.Importer
  
  def self.refresh(user)
    import_config = {}
    
    zendesk_username = user.settings.find_by_source_and_key('zendesk', 'username').try(:value)
    zendesk_password = user.settings.find_by_source_and_key('zendesk', 'password').try(:value)
    zendesk_subdomain = user.settings.find_by_source_and_key('zendesk', 'subdomain').try(:value)
    zendesk_ssl = user.settings.find_by_source_and_key('zendesk', 'ssl').try(:value)
    if(zendesk_username.present? && zendesk_password.present? && zendesk_subdomain.present? && zendesk_ssl.present?)
      import_config['zendesk'] = {
        'username' => zendesk_username,
        'password' => zendesk_password,
        'subdomain' => zendesk_subdomain,
        'ssl' => zendesk_ssl
      }
    end

    podio_username = user.settings.find_by_source_and_key('podio', 'username').try(:value)
    podio_password = user.settings.find_by_source_and_key('podio', 'password').try(:value)
    if(podio_username.present? && podio_password.present?)
      import_config['podio'] = {
        'username' => podio_username,
        'password' => podio_password
      }
    end

    importer = Importer.new(import_config)
    
    importer.achievements.each do |achievement|
      achievement_date = Time.at(achievement.date.to_date.time/1000)
      if user.last_updated_at.blank? || achievement_date > user.last_updated_at
        user.achievements.create(
          :source => achievement.source,
          :action => achievement.action,
          :timestamp => achievement_date,
          :description => achievement.description,
          :points => achievement.points
        )
        user.points ||= 0
        user.points += achievement.points
      end
    end
    
    user.last_updated_at = Time.now
    user.save
  end
  
end
