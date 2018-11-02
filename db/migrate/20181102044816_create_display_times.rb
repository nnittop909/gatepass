class CreateDisplayTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :display_times, id: :uuid do |t|
      t.integer :number_of_seconds

      t.timestamps
    end
  end
end
