class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses, id: :uuid do |t|
      t.string :name
      t.string :abbreviation
      t.belongs_to :course_duration, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
