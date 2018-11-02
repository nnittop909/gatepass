class CreateOpennings < ActiveRecord::Migration[5.2]
  def change
    create_table :opennings, id: :uuid do |t|
      t.datetime :openning_date

      t.timestamps
    end
  end
end
