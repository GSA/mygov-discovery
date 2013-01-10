class DomainsController < ApplicationController

  def show
   respond_to do |format|
      format.json { render json: Domain.find(params[:id]), :callback => params[:callback] }
    end
  end
  
  def index
    if params[:q].nil?
      render :json => { :status => "Error", :message => "Bad Request. Must include a query."}, :status => 406
    else
      q = params[:q] + "%"
      page = params[:page] || 1
      render :json => Domain.where("hostname_reversed LIKE ?", q).paginate(:page => page).as_json(:pages => true), :callback => params[:callback]
    end
  end
  
end