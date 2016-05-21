class AddUserRefToSample < ActiveRecord::Migration
  def change
    add_reference :samples, :user, index: true
  end
end
