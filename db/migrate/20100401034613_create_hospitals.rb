class CreateHospitals < ActiveRecord::Migration
  def self.up
    create_table :hospitals do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :zip
      t.string :url
      t.string :comment
      
      t.integer :state_id
      t.integer :county_id
      
      t.decimal :latitude, :precision => 9, :scale => 6
      t.decimal :longitude, :precision => 9, :scale => 6
      t.timestamp
    end
  end

  def self.down
    drop_table :hospitals
  end
end
