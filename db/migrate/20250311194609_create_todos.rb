class CreateTodos < ActiveRecord::Migration[8.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.string :status
      t.datetime :due_date

      t.timestamps
    end
  end
end
