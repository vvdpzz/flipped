class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.references :school
      t.string :name, :null => false

      t.timestamps
    end
    add_index :locations, :school_id
  end

  def self.down
    drop_table :locations
  end
end
