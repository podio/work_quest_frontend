class SettingsController < ApplicationController
  def edit
  end

  def update
    params[:settings].each do |setting_params|
      Setting.find_or_create_by_source_and_key(setting_params)
    end
    redirect_to edit_settings_path, :notice => 'Updated your settings.'
  end

end
