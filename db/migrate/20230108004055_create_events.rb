class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.integer :issue_id, null: false
      t.string :action, null: false
      t.json :author

      t.timestamps
    end
  end
end
