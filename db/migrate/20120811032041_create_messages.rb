class CreateMessages < ActiveRecord::Migration
  def change
    create_table :news_feed_sample_app_messages do |t|
      t.string :title
      t.timestamps
    end
  end
end
