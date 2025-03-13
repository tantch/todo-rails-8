# frozen_string_literal: true

class TodoSerializer
  def initialize(todo)
    @todo = todo
  end

  def as_json(*)
    {
      id: @todo.id,
      title: @todo.title,
      description: @todo.description,
      status: @todo.status,
      due_date: @todo.due_date
    }
  end
end