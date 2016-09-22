class AddCompletedFieldToHomework < ActiveRecord::Migration
  def change
    change_table :homeworks do |t|
        t.boolean "completed"
    end
  end
end
