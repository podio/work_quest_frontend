class CreateAchievements < ActiveRecord::Migration
  def self.up
    create_table :achievements do |t|
      t.integer :user_id
      t.string :source
      t.string :action
      t.datetime :timestamp
      t.integer :points

      t.timestamps
    end
  end

  def self.down
    drop_table :achievements
  end
end
