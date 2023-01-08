class EventsController < ApplicationController
  before_action :authenticate_webhook!, only: [:create]
  before_action :authenticate_user!, only: [:index]

  # POST events/ (webhook)
  def create
    response = Events::Create.new(params).execute
    head :ok
  end

  # GET issues/:id/events
  def index
    events = Event.where({issue_id: params[:id]})
    raise ActiveRecord::RecordNotFound if events.blank?

    render json: events, each_serializer: EventsSerializer, status: :ok
  end
end