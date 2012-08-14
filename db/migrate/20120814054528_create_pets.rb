class CreatePets < ActiveRecord::Migration
  def up
    create_table :pets do |t|
      t.string :name
      t.timestamps
    end
    
    rename_column :messages, :title, :name
    remove_column :users, :first_name
    remove_column :users, :last_name
    add_column :users, :name, :string
  end
  
  def down
    drop_table :pets
    rename_column :messages, :name, :title
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    remove_column :users, :name
  end
end
