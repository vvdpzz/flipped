class CreateSchools < ActiveRecord::Migration
  def self.up
    create_table :schools do |t|
      t.references :province, :null => false
      t.string :name, :null => false
      t.string :abbr, :null => false
      t.integer :tweets_count

      t.timestamps
    end
    add_index :schools, :province_id
    add_index :schools, :abbr, :unique => true
  end

  def self.down
    drop_table :schools
  end
end
