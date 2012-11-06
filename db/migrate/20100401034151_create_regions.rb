class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.string :type
      
      # common attributes
      t.integer :fips
      t.string :name
      
      # state attributes
      t.string :abbr
      
      # county attributes
      t.integer :state_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :regions
  end
end
