class CreateYearLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :year_levels, id: :uuid do |t|
      t.string :name
      t.integer :level

      t.timestamps
    end
  end
end
