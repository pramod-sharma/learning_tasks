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

ActiveRecord::Schema.define(version: 20131231125252) do

  create_table "employees", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "designation",       limit: 1
    t.integer  "potential_revenue",           default: 0
    t.integer  "actual_revenue",              default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_id"
    t.integer  "team_lead_id"
    t.boolean  "is_admin"
    t.datetime "deleted_at"
    t.boolean  "active",                      default: true
    t.date     "relieving_date"
  end

  add_index "employees", ["team_id"], name: "index_employees_on_team_id", using: :btree
  add_index "employees", ["team_lead_id"], name: "index_employees_on_team_lead_id", using: :btree

  create_table "monthly_billings", force: true do |t|
    t.integer  "amount"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "billing_date"
  end

  add_index "monthly_billings", ["project_id"], name: "index_monthly_billings_on_project_id", using: :btree

  create_table "project_assignments", force: true do |t|
    t.integer  "employee_id"
    t.integer  "project_id"
    t.date     "relieving_date"
    t.integer  "involvement",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "join_from"
    t.boolean  "auto_relieve",   default: true
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.boolean  "active",               default: true
    t.integer  "state",      limit: 1
  end

  create_table "revenue_projections", force: true do |t|
    t.integer  "actual_revenue",    default: 0
    t.integer  "potential_revenue", default: 0
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
  end

  add_index "revenue_projections", ["employee_id"], name: "index_revenue_projections_on_employee_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

end
