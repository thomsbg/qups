class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.string  :name
      t.string  :domain
      t.string  :thumbnail
      t.text    :description
      t.string  :url
      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
