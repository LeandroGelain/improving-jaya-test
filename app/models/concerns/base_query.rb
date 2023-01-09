module BaseQuery
  extend ActiveSupport::Concern

  included do
    extend ClassMethods
  end

  module ClassMethods
    def search_by(params)
      query = ransack(format_params(params))
      query.result
    end
  end
end
