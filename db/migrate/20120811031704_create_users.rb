class CreateUsers < ActiveRecord::Migration
  def change
    create_table :news_feed_sample_app_users do |t|
      t.string :name
      t.timestamps
    end
  end
end
