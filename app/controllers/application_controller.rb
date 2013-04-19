class ApplicationController < ActionController::Base
  before_filter :cors_preflight_check
  before_filter :authenticate
  after_filter :cors_set_access_control_headers
  after_filter :set_response_headers
  
  def cors
    render :nothing => true
  end

  protected
  
  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.
  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Content-Type'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

  def authenticate
    ip = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip || "localhost"
    @current_user = User.find_or_create_by_ip ip
    head :unauthorized if @current_user.blocked
  end

  # For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end
  
  def set_response_headers
    headers['X-Frame-Options'] = 'SAMEORIGIN'
  end
end