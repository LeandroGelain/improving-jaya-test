module UserAuthHelper
  def authenticate_user!
    @user_name = request.headers["HTTP_USER_NAME"]
    @password = request.headers["HTTP_PASSWORD"]

    credentials_is_valid?
  end

  def credentials_is_valid?
    raise Errors::Unauthorized unless @user_name.present? && @password.present?
    raise Errors::Unauthorized unless @user_name == ENV['USER_NAME'] && @password == ENV['USER_PASSWORD']
      
    return true
  end
end