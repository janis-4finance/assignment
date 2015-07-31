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

ActiveRecord::Schema.define(version: 20150731092744) do

  create_table "loans", id: false, force: :cascade do |t|
    t.string   "uuid",                 limit: 36
    t.string   "user_id",              limit: 36
    t.decimal  "apr",                              precision: 8, scale: 4
    t.decimal  "principal",                        precision: 8, scale: 2
    t.decimal  "interest",                         precision: 8, scale: 2
    t.decimal  "total",                            precision: 8, scale: 2
    t.decimal  "original_apr",                     precision: 8, scale: 4
    t.decimal  "original_interest",                precision: 8, scale: 2
    t.date     "submission_date"
    t.integer  "submission_timestamp", limit: 8
    t.boolean  "approved",                                                 default: false
    t.boolean  "disbursed",                                                default: false
    t.boolean  "repaid",                                                   default: false
    t.date     "maturity_date"
    t.string   "user_ip",              limit: 255
    t.string   "decline_reason",       limit: 255
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
  end

  create_table "users", id: false, force: :cascade do |t|
    t.string   "uuid",       limit: 36
    t.string   "name",       limit: 255
    t.string   "phone",      limit: 255
    t.string   "iban",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "users", ["iban"], name: "index_users_on_iban", unique: true, using: :btree

end
