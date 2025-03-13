class Api::V1::TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :initiate_todo, only: %i[show update destroy]

  def index
    todos = current_user.admin? ? Todo.all : current_user.todos

    todos = todos.where(status: params[:status]) if params[:status].present?
    if params[:start_date].present? && params[:end_date].present?
      todos = todos.where(due_date: params[:start_date]..params[:end_date])
    end

    render json: todos
  end

  def show
    render json: @todo
  end

  def create
    todo = current_user.todos.new(todo_params)
    todo.save
    render json: todo, status: :created
  end

  def update
    @todo.update(todo_params)
    render json: @todo
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def initiate_todo
    @todo = current_user.admin? ? Todo.find(params[:id]) : current_user.todos.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(
      :title,
      :description,
      :status,
      :due_date
    )
  end
end
