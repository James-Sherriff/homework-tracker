class AddColsToHomework < ActiveRecord::Migration
  def change
      change_table :homeworks do |t|
        t.string :title
        t.string :content
        t.string :file_link
      end
  end
end