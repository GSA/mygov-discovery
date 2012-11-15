class HomeController < ActionController::Base

  def mygov_bar
    render "mygov_bar", :layout => "application"
  end
  
end
