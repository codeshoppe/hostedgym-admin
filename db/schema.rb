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

ActiveRecord::Schema.define(version: 20160213192126) do

  create_table "articles", force: :cascade do |t|
    t.string  "title"
    t.text    "body"
    t.integer "author_id"
  end

  add_index "articles", ["author_id"], name: "index_articles_on_author_id"

  create_table "braintree_customers", force: :cascade do |t|
    t.string   "customer_id"
    t.string   "invited_plan_id"
    t.string   "subscription_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "clinics", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "spots_available"
    t.decimal  "price"
    t.datetime "scheduled_for"
    t.boolean  "open_for_registration", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer_accounts", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "invited_plan_id"
    t.string   "subscription_id"
    t.string   "type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                  default: false, null: false
    t.integer  "customer_account_id"
  end

  add_index "users", ["customer_account_id"], name: "index_users_on_customer_account_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
