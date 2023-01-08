class Events::Create
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def execute
    register_event!
  end

  private

  def register_event!
    Event.create!(format_params)
  end

  def format_params
    {
      issue_id: params[:issue][:number],
      action: params[:event][:action],
      author: params[:sender]
    }
  end
end