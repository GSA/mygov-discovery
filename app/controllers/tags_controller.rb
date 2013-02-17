class TagsController < ApplicationController

  def show
    render :json => Page.tagged_with(params[:id]), :callback => params[:callback]
  end
  
  def index
    if params[:q].nil?
      render :json => {:status => "Error", :message => "query parameter required"}, :status => 400, :callback => params[:callback]
    else
      render :json => ActsAsTaggableOn::Tag.named_like( params[:q] ), :callback => params[:callback]
    end
  end
end