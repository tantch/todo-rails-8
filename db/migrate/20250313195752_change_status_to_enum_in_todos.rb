class ChangeStatusToEnumInTodos < ActiveRecord::Migration[8.0]
  def change
    remove_column :todos, :status, :string
    add_column :todos, :status, :integer, default: 0, null: false
  end
end
