class AddUserToHomework < ActiveRecord::Migration
  def change
      change_table :homeworks do |t|
        t.string :user
      end
  end
end
