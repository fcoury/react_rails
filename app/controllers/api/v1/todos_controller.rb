class Api::V1::TodosController < ApplicationController
  respond_to :json

  def create
    if @todo = Todo.create(todo_params)
      respond_with(@todo)
    else
      render status: 422
    end
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update_attributes(todo_params)
      respond_with(@todo)
    else
      render status: 422, errors: @todo.errors
    end
  end

  def todo_params
    params.require(:todo).permit(:description, :checked)
  end
end
