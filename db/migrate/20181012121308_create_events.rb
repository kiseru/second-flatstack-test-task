class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.datetime :date, null: false
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
