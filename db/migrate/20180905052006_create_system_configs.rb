class CreateSystemConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :system_configs, id: :uuid do |t|
    	t.string :name
      t.integer :display_time
      t.datetime :deployment_date

      t.timestamps
    end
  end
end
