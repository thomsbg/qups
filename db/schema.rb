# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100401034613) do

  create_table "hospitals", :force => true do |t|
    t.string  "name"
    t.string  "address1"
    t.string  "address2"
    t.string  "city"
    t.string  "zip"
    t.string  "url"
    t.string  "comment"
    t.integer "state_id"
    t.integer "county_id"
    t.decimal "latitude",  :precision => 9, :scale => 6
    t.decimal "longitude", :precision => 9, :scale => 6
  end

  create_table "regions", :force => true do |t|
    t.string   "type"
    t.integer  "fips"
    t.string   "name"
    t.string   "abbr"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", :force => true do |t|
    t.string   "name"
    t.string   "domain"
    t.string   "thumbnail"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
