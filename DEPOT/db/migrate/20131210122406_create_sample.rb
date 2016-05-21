class CreateSample < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.string :name
      t.integer :phone
    end
  end
end
