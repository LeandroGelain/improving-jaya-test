class EventsController < ApplicationController

  def create
    response = Events::Create.new(params).execute
    render json: params
  end

  def index
    response = Events::Create.new(params[:id]).execute
    render json: response
  end
end