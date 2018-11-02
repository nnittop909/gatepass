class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses, id: :uuid do |t|
      t.string :name
      t.string :abbreviation

      t.timestamps
    end
  end
end
