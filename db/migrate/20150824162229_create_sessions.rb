class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.datetime :end_time
      t.timestamps null: false
    end
  end
end
