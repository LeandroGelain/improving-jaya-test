module EventQuery
  extend ActiveSupport::Concern

  included do
    extend ClassMethods
  end

  module ClassMethods
    def format_params(params)
      return {} if params.blank?

      {
        id_eq: params[:id],
        issue_id_eq: params[:issue_id],
        action_eq: params[:action]
      }
    end

    def format_order(order = '')
      order.presence || ['id DESC']
    end
  end
end
