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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150725145647) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exam_images", force: :cascade do |t|
    t.string "dgt_url"
    t.string "storage_url"
  end

  add_index "exam_images", ["dgt_url"], name: "index_exam_images_on_dgt_url", using: :btree

  create_table "exams", force: :cascade do |t|
    t.string   "code"
    t.string   "lng"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "url"
    t.text     "metadata"
    t.text     "answers"
    t.text     "typeform_data"
    t.text     "mapped"
  end

end
