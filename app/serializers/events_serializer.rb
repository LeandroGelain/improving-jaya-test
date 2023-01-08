class EventsSerializer < ActiveModel::Serializer
  attributes :id, :issue_id, :action, :author, :created_at, :updated_at

  def author
    {
      id: object.author["id"],
      user_name: object.author["login"]
    }
  end
end
