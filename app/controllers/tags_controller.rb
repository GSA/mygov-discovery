class TagsController < ApplicationController

  def index
    q = params[:q] || ""
    render json: ActsAsTaggableOn::Tag.named_like(q), :callback => params[:callback]
  end

  def show
    tag = ActsAsTaggableOn::Tag.find(params[:id])
    render json: Page.tagged_with(tag), :callback => params[:callback]
  end
  
end
