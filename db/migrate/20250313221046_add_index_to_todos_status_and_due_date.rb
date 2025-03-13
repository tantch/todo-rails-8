class AddIndexToTodosStatusAndDueDate < ActiveRecord::Migration[8.0]
  def change
    add_index :todos, :status
    add_index :todos, :due_date
  end
end
