class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs, id: :uuid do |t|
      t.integer :remark
      t.datetime :log_time
      t.belongs_to :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
