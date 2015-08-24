class AddSessionToFeelings < ActiveRecord::Migration
  def change
    add_column :feelings, :session_id, :integer
  end
end
