class CreateJoinTableUserSample < ActiveRecord::Migration
  def change
    create_join_table :users, :samples
  end
end