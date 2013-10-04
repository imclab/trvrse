# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120731211058) do

  create_table "comments", :force => true do |t|
    t.integer  "rating"
    t.integer  "user_id"
    t.integer  "trip_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["trip_id"], :name => "index_comments_on_trip_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "likes", :force => true do |t|
    t.integer  "verse_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "likes", ["user_id"], :name => "index_likes_on_user_id"
  add_index "likes", ["verse_id"], :name => "index_likes_on_verse_id"

  create_table "list_items", :force => true do |t|
    t.integer  "location_id"
    t.integer  "list_id"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "list_items", ["list_id"], :name => "index_list_items_on_list_id"
  add_index "list_items", ["location_id"], :name => "index_list_items_on_location_id"

  create_table "lists", :force => true do |t|
    t.text     "description"
    t.integer  "user_id"
    t.string   "to_what"
    t.string   "tags"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "lists", ["user_id"], :name => "index_lists_on_user_id"

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "lat"
    t.string   "long"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "image"
    t.string   "description"
  end

  create_table "places", :force => true do |t|
    t.string "display_name"
    t.string "city_name"
    t.string "state_code"
    t.string "latitude"
    t.string "longitude"
  end

  create_table "points", :force => true do |t|
    t.string   "name"
    t.decimal  "lat"
    t.decimal  "long"
    t.integer  "place_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "points", ["place_id"], :name => "index_points_on_place_id"

  create_table "trips", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tripit_id"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "location_id"
    t.string   "image_url"
    t.date     "start_date"
    t.date     "end_date"
  end

  add_index "trips", ["location_id"], :name => "index_trips_on_location_id"
  add_index "trips", ["user_id"], :name => "index_trips_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "tripit_ref"
    t.string   "authorized_key"
    t.string   "authorized_secret"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "email"
  end

  create_table "verses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "point_id"
    t.string   "caption"
    t.string   "tags"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.decimal  "lat"
    t.decimal  "long"
    t.integer  "trip_id"
  end

  add_index "verses", ["point_id"], :name => "index_verses_on_point_id"
  add_index "verses", ["user_id"], :name => "index_verses_on_user_id"

end
