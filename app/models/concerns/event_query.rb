module EventQuery
  extend ActiveSupport::Concern

  include BaseQuery

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
  end
end
