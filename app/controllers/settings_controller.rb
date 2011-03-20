class SettingsController < ApplicationController
  def edit
  end

  def update
    current_user.settings.delete_all
    params.each do |key, value|
      setting, source, name = key.split('_')
      if setting == 'setting'
        Setting.find_or_create_by_user_id_and_source_and_key(:user_id => current_user.id, :source => source, :key => name, :value => value)
      end
    end
    redirect_to edit_settings_path, :notice => 'Updated your settings.'
  end

end
