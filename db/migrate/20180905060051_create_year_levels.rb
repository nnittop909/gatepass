class CreateYearLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :year_levels do |t|
      t.string :name

      t.timestamps
    end
  end
end
