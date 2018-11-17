class CreateCourseDurations < ActiveRecord::Migration[5.2]
  def change
    create_table :course_durations, id: :uuid do |t|
      t.string :name
      t.decimal :duration

      t.timestamps
    end
  end
end
