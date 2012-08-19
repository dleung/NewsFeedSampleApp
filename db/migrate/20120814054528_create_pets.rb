class CreatePets < ActiveRecord::Migration
  def up
    create_table :news_feed_sample_app_pets do |t|
      t.string :name
      t.timestamps
    end
    
    rename_column :news_feed_sample_app_messages, :title, :name
    NewsFeedSampleApp::User.create!( name: "Anonymous" )
  end
  
  def down
    drop_table :news_feed_sample_app_pets
    rename_column :news_feed_sample_app_messages, :name, :title
    add_column :news_feed_sample_app_users, :first_name, :string
    add_column :news_feed_sample_app_users, :last_name, :string
    remove_column :news_feed_sample_app_users, :name
  end
end
