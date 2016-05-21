class RemovePhoneFromSample < ActiveRecord::Migration
  def change
    remove_column :samples, :phone, :integer
  end
end
