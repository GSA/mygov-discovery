class CommentsController < ApplicationController
  before_filter :assign_page
  
  def index
    page = params[:page] || 1
    render :json => @page.comments.paginate(:page => page).order("created_at DESC"), :callback => params[:callback]
  end

  def create
    comment = @current_user.comments.new(:body => params[:body])
    comment.page_id = @page.id
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end
  
  private
  
  def assign_page
    @page = Page.find_by_id(params[:page_id])
  end
end