class AddUserIdToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :user_id, :integer
  end
end
