class DomainsController < ApplicationController

  def show
   respond_to do |format|
      format.json { render json: Domain.find(params[:id]), :callback => params[:callback] }
    end
  end
  
  def index
    respond_to do |format|
      if params[:q].nil?
        format.json { head :bad_request }
      else
        q = params[:q] + "%"
        format.json { render json: Domain.where("hostname_reversed LIKE ?", q), :callback => params[:callback] }
      end
    end
  end
  
end