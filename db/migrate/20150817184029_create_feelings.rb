class CreateFeelings < ActiveRecord::Migration
  def change
    create_table :feelings do |t|
      t.string :text
      t.timestamps null: false
    end
  end
end
